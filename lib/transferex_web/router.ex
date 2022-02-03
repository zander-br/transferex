defmodule TransferexWeb.Router do
  use TransferexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Casex.CamelCaseDecoderPlug
  end

  scope "/api", TransferexWeb do
    pipe_through :api

    post "/transfers", TransfersController, :create
  end
end
