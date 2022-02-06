defmodule Transferex.Transfers.Core.CreateTransferTest do
  use Transferex.DataCase, async: true

  alias Ecto.Changeset
  alias Transferex.Transfers.Core.CreateTransfer
  alias Transferex.Transfers.Data.Transfer
  alias Transferex.Transfers.Workers.Liquidation, as: LiquidationWorker

  describe "execute/1" do
    test "when all params is valid, returns the transfer" do
      valid_transfer = build(:transfer_attrs)

      response = CreateTransfer.execute(valid_transfer)
      {:ok, %Transfer{id: id}} = response

      assert {:ok, %Transfer{id: _id, inserted_at: _inserted_at, status: :created}} = response
      assert_enqueued(worker: LiquidationWorker, queue: :default, args: %{"id" => id})
    end

    test "when there is invalid due_date, returns an error" do
      invalid_transfer = build(:transfer_attrs, %{"due_date" => "01/01/2000"})

      response = CreateTransfer.execute(invalid_transfer)

      assert {:error, {:unprocessable_entity, %{due_date: "invalid format"}}} = response
      refute_enqueued(worker: LiquidationWorker)
    end

    test "when all params is valid and due_date is today, returns the transfer with status :created" do
      due_date_in_today = Date.utc_today() |> Date.to_string()
      valid_transfer = build(:transfer_attrs, %{"due_date" => due_date_in_today})

      response = CreateTransfer.execute(valid_transfer)
      {:ok, %Transfer{id: id}} = response

      assert {:ok, %Transfer{id: _id, inserted_at: _inserted_at, status: :created}} = response
      assert_enqueued(worker: LiquidationWorker, queue: :default, args: %{"id" => id})
    end

    test "when all params is valid and due_date is past, returns the transfer with status :rejected" do
      valid_transfer = build(:transfer_attrs, %{"due_date" => "2000-01-01"})

      response = CreateTransfer.execute(valid_transfer)

      assert {:ok, %Transfer{id: _id, inserted_at: _inserted_at, status: :rejected}} = response
      refute_enqueued(worker: LiquidationWorker)
    end

    test "when all params is valid and due_date is future, returns the transfer with status :scheduled" do
      due_date_in_future = Date.utc_today() |> Date.add(1) |> Date.to_string()
      {:ok, standard_time_for_liquidation} = Time.from_iso8601("10:00:00")

      valid_transfer = build(:transfer_attrs, %{"due_date" => due_date_in_future})

      response = CreateTransfer.execute(valid_transfer)
      {:ok, %Transfer{id: id, due_date: due_date}} = response
      {:ok, scheduled_liquidation} = DateTime.new(due_date, standard_time_for_liquidation)

      assert {:ok, %Transfer{id: _id, inserted_at: _inserted_at, status: :scheduled}} = response

      assert_enqueued(
        worker: LiquidationWorker,
        queue: :default,
        args: %{"id" => id},
        scheduled_at: scheduled_liquidation
      )
    end

    test "when there is invalid params, returns an error" do
      invalid_transfer = build(:transfer_attrs, %{"amount" => 0})
      expected_response = %{amount: ["must be greater than 0"]}

      response = CreateTransfer.execute(invalid_transfer)

      assert {:error, {:unprocessable_entity, %Changeset{valid?: false} = changeset}} = response
      assert errors_on(changeset) == expected_response
      refute_enqueued(worker: LiquidationWorker)
    end
  end
end
