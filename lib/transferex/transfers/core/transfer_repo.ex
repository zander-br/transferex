defmodule Transferex.Transfers.Core.TransferRepo do
  alias Transferex.Repo
  alias Transferex.Transfers.Data.Transfer

  def create_transfer(transfer) do
    transfer
    |> Transfer.changeset()
    |> Repo.insert()
  end

  def update_transfer(transfer, params) do
    transfer
    |> Transfer.changeset(params)
    |> Repo.update()
  end

  def get_by_id(id), do: Repo.get(Transfer, id)
end
