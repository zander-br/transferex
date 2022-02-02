defmodule Transferex.Transfers.Data.Transfer do
  use Ecto.Schema

  import Ecto.Changeset

  @fields [:value, :due_date, :origin_account_id, :destination_account_id]
  @required_fields [:value, :origin_account_id, :destination_account_id]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transfers" do
    field :value, :decimal
    field :due_date, :naive_datetime
    field :origin_account_id, :binary_id
    field :destination_account_id, :binary_id
  end

  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> validate_number(:value, greater_than: 0)
  end
end
