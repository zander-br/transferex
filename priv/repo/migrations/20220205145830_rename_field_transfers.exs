defmodule Transferex.Repo.Migrations.RenameFieldTransfers do
  use Ecto.Migration

  def change do
    rename table(:transfers), :value, to: :amount
  end
end
