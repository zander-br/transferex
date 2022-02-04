# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :transferex,
  ecto_repos: [Transferex.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :transferex, TransferexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TRHOSLDQXfwbhaA39oPQs9Cp/ArfAeUMK7MzpTyarGh9glVx0tW0RPIQi88C++2P",
  render_errors: [view: TransferexWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Transferex.PubSub,
  live_view: [signing_salt: "66zAbDMD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :format_encoders, json: Casex.CamelCaseEncoder

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

if Mix.env() == :dev do
  config :git_hooks,
    auto_install: true,
    hooks: [
      pre_commit: [
        tasks: [
          {:cmd, "mix format --check-formatted"}
        ]
      ],
      pre_push: [
        verbose: false,
        tasks: [
          {:cmd, "mix credo"},
          {:cmd, "mix test --color"}
        ]
      ]
    ]
end
