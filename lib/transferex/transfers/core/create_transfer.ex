defmodule Transferex.Transfers.Core.CreateTransfer do
  alias Transferex.Repo
  alias Transferex.Transfers.Data.Transfer

  def execute(transfer) do
    transfer
    |> add_status_transfer()
    |> Transfer.changeset()
    |> Repo.insert()
  end

  defp add_status_transfer(transfer) do
    Map.put(transfer, :status, :created)
  end
end
