defmodule Transferex.Repo.Migrations.CreateTransfer do
  use Ecto.Migration

  def change do
    create table(:transfers, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :value, :decimal, null: false
      add :due_date, :date, null: true
      add :origin_account_id, :binary_id, null: false
      add :destination_account_id, :binary_id, null: false
      add :status, :transfer_status, null: false

      timestamps()
    end
  end
end
