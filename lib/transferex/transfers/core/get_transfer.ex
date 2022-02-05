defmodule Transferex.Transfers.Core.GetTransfer do
  alias Transferex.Repo
  alias Transferex.Transfers.Data.Transfer

  def by_id(id) do
    transfer = Repo.get!(Transfer, id)
    {:ok, transfer}
  end
end
