defmodule TransferexWeb.TransfersController do
  use TransferexWeb, :controller

  alias Transferex.Transfers.Core.{CreateTransfer, GetTransfer}
  alias Transferex.Transfers.Data.Transfer
  alias TransferexWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Transfer{} = transfer} <- CreateTransfer.execute(params) do
      conn
      |> put_status(:created)
      |> render("create.json", transfer: transfer)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Transfer{} = transfer} <- GetTransfer.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", transfer: transfer)
    end
  end
end
