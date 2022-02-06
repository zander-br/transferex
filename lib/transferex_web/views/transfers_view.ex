defmodule TransferexWeb.TransfersView do
  use TransferexWeb, :view

  alias Transferex.Transfers.Data.Transfer

  def render("create.json", %{transfer: %Transfer{} = transfer}) do
    %{
      id: transfer.id,
      status: transfer.status
    }
  end

  def render("show.json", %{transfer: %Transfer{} = transfer}) do
    %{
      id: transfer.id,
      status: transfer.status,
      amount: transfer.amount,
      origin_account: transfer.origin_account_id,
      destination_account: transfer.destination_account_id,
      due_date: transfer.due_date,
      transfer_date: transfer.inserted_at,
      liquidation_id: transfer.liquidation_id,
      liquidation_date: transfer.liquidation_date
    }
  end
end
