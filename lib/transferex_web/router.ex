defmodule TransferexWeb.Router do
  use TransferexWeb, :router

  alias TransferexWeb.Plug.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug Casex.CamelCaseDecoderPlug
    plug UUIDChecker
  end

  scope "/api", TransferexWeb do
    pipe_through :api

    post "/transfers", TransfersController, :create
    get "/transfers/:id", TransfersController, :show
  end
end
