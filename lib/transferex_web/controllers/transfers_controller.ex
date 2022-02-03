defmodule TransferexWeb.TransfersController do
  use TransferexWeb, :controller

  alias Transferex.Transfers.Core.CreateTransfer
  alias Transferex.Transfers.Data.Transfer

  def create(conn, params) do
    with {:ok, %Transfer{} = transfer} <- CreateTransfer.execute(params) do
      conn
      |> put_status(:created)
      |> render("create.json", transfer: transfer)
    end
  end
end
