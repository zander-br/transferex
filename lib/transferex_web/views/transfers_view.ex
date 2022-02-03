defmodule TransferexWeb.TransfersView do
  use TransferexWeb, :view

  alias Transferex.Transfers.Data.Transfer

  def render("create.json", %{transfer: %Transfer{} = transfer}) do
    %{
      id: transfer.id,
      status: transfer.status
    }
  end
end
