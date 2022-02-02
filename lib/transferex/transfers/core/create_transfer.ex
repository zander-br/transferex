defmodule Transferex.Transfers.Core.CreateTransfer do
  alias Transferex.Repo
  alias Transferex.Transfers.Data.Transfer

  def execute(transfer) do
    transfer
    |> add_status_transfer()
    |> Transfer.changeset()
    |> Repo.insert()
  end

  defp add_status_transfer(%{due_date: due_date} = transfer) do
    now = Date.utc_today()
    due_date = Date.from_iso8601!(due_date)

    case Date.compare(due_date, now) do
      :lt -> Map.put(transfer, :status, :rejected)
      :gt -> Map.put(transfer, :status, :scheduled)
      _ -> Map.put(transfer, :status, :created)
    end
  end

  defp add_status_transfer(transfer) do
    Map.put(transfer, :status, :created)
  end
end
