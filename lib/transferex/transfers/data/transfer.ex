defmodule Transferex.Transfers.Data.Transfer do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Enum
  alias Ecto.UUID

  @fields [:amount, :due_date, :origin_account_id, :destination_account_id, :status]
  @required_fields [:amount, :origin_account_id, :destination_account_id, :status]
  @transfer_status [:created, :aproved, :scheduled, :rejected]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transfers" do
    field :amount, :decimal
    field :due_date, :date
    field :origin_account_id, :binary_id
    field :destination_account_id, :binary_id
    field :status, Enum, values: @transfer_status

    timestamps()
  end

  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> validate_number(:amount, greater_than: 0)
    |> validate_uuid(:origin_account_id)
    |> validate_uuid(:destination_account_id)
  end

  defp validate_uuid(changeset, field, options \\ []) when is_atom(field) do
    validate_change(changeset, field, fn _, student_id ->
      case UUID.cast(student_id) do
        :error -> [{field, options[:message] || "invalid uuid"}]
        {:ok, _uuid} -> []
      end
    end)
  end
end
