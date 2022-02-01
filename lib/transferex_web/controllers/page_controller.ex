defmodule TransferexWeb.PageController do
  use TransferexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
