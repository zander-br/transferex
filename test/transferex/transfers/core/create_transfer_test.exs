defmodule Transferex.Transfers.Core.CreateTransferTest do
  use Transferex.DataCase, async: true

  alias Ecto.Changeset
  alias Transferex.Transfers.Core.CreateTransfer
  alias Transferex.Transfers.Data.Transfer

  describe "execute/1" do
    test "when all params is valid, returns the transfer" do
      valid_transfer = build(:transfer_attrs)

      response = CreateTransfer.execute(valid_transfer)

      assert {:ok, %Transfer{id: _id, inserted_at: _inserted_at, status: :created}} = response
    end

    test "when all params is valid and due_date is today, returns the transfer with status :created" do
      due_date_in_today = Date.utc_today() |> Date.to_string()
      valid_transfer = build(:transfer_attrs, due_date: due_date_in_today)

      response = CreateTransfer.execute(valid_transfer)

      assert {:ok, %Transfer{id: _id, inserted_at: _inserted_at, status: :created}} = response
    end

    test "when all params is valid and due_date is past, returns the transfer with status :rejected" do
      valid_transfer = build(:transfer_attrs, due_date: "2000-01-01")

      response = CreateTransfer.execute(valid_transfer)

      assert {:ok, %Transfer{id: _id, inserted_at: _inserted_at, status: :rejected}} = response
    end

    test "when all params is valid and due_date is future, returns the transfer with status :scheduled" do
      due_date_in_future = Date.utc_today() |> Date.add(1) |> Date.to_string()
      valid_transfer = build(:transfer_attrs, due_date: due_date_in_future)

      response = CreateTransfer.execute(valid_transfer)

      assert {:ok, %Transfer{id: _id, inserted_at: _inserted_at, status: :scheduled}} = response
    end

    test "when there is invalid params, returns an error" do
      invalid_transfer = build(:transfer_attrs, value: 0)
      expected_response = %{value: ["must be greater than 0"]}

      response = CreateTransfer.execute(invalid_transfer)

      assert {:error, %Changeset{valid?: false} = changeset} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
