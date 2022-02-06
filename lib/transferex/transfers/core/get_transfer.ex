defmodule Transferex.Transfers.Core.GetTransfer do
  alias Transferex.Transfers.Core.TransferRepo

  def by_id(id) do
    case TransferRepo.get_by_id(id) do
      nil -> {:error, {:not_found, "transfer not found"}}
      transfer -> {:ok, transfer}
    end
  end
end
