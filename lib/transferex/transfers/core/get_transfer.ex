defmodule Transferex.Transfers.Core.GetTransfer do
  alias Transferex.Repo
  alias Transferex.Transfers.Data.Transfer

  def by_id(id) do
    case Repo.get(Transfer, id) do
      nil -> {:error, {:not_found, "transfer not found"}}
      transfer -> {:ok, transfer}
    end
  end
end
