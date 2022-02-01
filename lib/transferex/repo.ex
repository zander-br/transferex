defmodule Transferex.Repo do
  use Ecto.Repo,
    otp_app: :transferex,
    adapter: Ecto.Adapters.Postgres
end
