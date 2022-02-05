defmodule Transferex.Repo.Migrations.RenameTypeTransferStatus do
  use Ecto.Migration

  def change do
    query = "ALTER TYPE transfer_status RENAME VALUE 'aproved' TO 'approved'"

    execute(query)
  end
end
