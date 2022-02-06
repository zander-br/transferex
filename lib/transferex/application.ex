defmodule Transferex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Transferex.Repo,
      # Start the Telemetry supervisor
      TransferexWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Transferex.PubSub},
      # Start the Endpoint (http/https)
      TransferexWeb.Endpoint,
      # Start the Oban
      {Oban, oban_config()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Transferex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TransferexWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp oban_config do
    Application.fetch_env!(:transferex, Oban)
  end
end
