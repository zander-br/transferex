defmodule Transferex.Transfers.Service.Liquidation do
  use Tesla

  alias Tesla.Env
  alias Transferex.Repo
  alias Transferex.Transfers.Data.Transfer

  plug Tesla.Middleware.Headers, [{"User-Agent", "request"}]
  plug Tesla.Middleware.JSON

  def execute(url, transfer_id) do
    transfer = Repo.get!(Transfer, transfer_id)
    liquidation_data = create_liquidation_data(transfer)

    "#{url}/paymentOrders"
    |> post(liquidation_data)
    |> handle_post(transfer)
  end

  defp create_liquidation_data(%Transfer{} = transfer) do
    transfer
    |> add_external_id()
    |> add_amount(transfer)
    |> add_expected_liquidation(transfer)
  end

  defp handle_post({:ok, %Env{status: 201, body: body}}, %Transfer{} = transfer) do
    %{"internalId" => liquidation_id, "status" => status} = body

    liquidation = %{
      liquidation_id: liquidation_id,
      status: String.downcase(status),
      liquidation_date: NaiveDateTime.utc_now()
    }

    changeset = Transfer.changeset(transfer, liquidation)
    Repo.update(changeset)

    :ok
  end

  defp add_external_id(%Transfer{id: id}), do: %{"externalId" => id}

  defp add_amount(liquidation, %Transfer{amount: amount}) do
    amount = amount |> Decimal.mult(1000) |> Decimal.to_integer()
    Map.put(liquidation, "amount", amount)
  end

  defp add_expected_liquidation(liquidation, %Transfer{due_date: due_date})
       when due_date != nil do
    expected_on = format_expected_liquidation(due_date)
    Map.put(liquidation, "expectedOn", expected_on)
  end

  defp add_expected_liquidation(liquidation, %Transfer{}) do
    expected_on = format_expected_liquidation(Date.utc_today())
    Map.put(liquidation, "expectedOn", expected_on)
  end

  defp format_expected_liquidation(expected_on) do
    Calendar.strftime(expected_on, "%d-%m-%Y")
  end
end
