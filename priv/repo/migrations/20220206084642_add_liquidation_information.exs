defmodule Transferex.Repo.Migrations.AddLiquidationInformation do
  use Ecto.Migration

  def change do
    alter table("transfers") do
      add :liquidation_id, :binary_id
      add :liquidation_date, :naive_datetime
    end
  end
end
