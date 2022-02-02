defmodule Transferex.Repo.Migrations.CreateStatusTransfer do
  use Ecto.Migration

  def change do
    up_query =
      "CREATE TYPE transfer_status AS ENUM ('created', 'aproved', 'scheduled', 'rejected')"

    down_query = "DROP TYPE transfer_status"

    execute(up_query, down_query)
  end
end
