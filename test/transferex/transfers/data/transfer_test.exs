defmodule Transferex.Transfers.Data.TransferTest do
  use Transferex.DataCase, async: true

  alias Ecto.Changeset
  alias Transferex.Transfers.Data.Transfer

  describe "changeset/2" do
    test "when all attrs is valid, return a valid changeset" do
      valid_attrs = build(:transfer_attrs)

      valid_transfer = Transfer.changeset(valid_attrs)

      assert %Changeset{
               changes: %{
                 destination_account_id: "a0868a72-8278-44ee-9125-b4035cdb2e09",
                 origin_account_id: "b007861e-806d-4580-b705-ac8eff473e2c"
               },
               valid?: true
             } = valid_transfer
    end

    test "when not informed required attributes, returns errors" do
      expected_response = %{
        value: ["can't be blank"],
        destination_account_id: ["can't be blank"],
        origin_account_id: ["can't be blank"]
      }

      invalid_transfer = Transfer.changeset(%{})

      assert errors_on(invalid_transfer) == expected_response
    end

    test "when there is invalid value, return an error" do
      invalid_attrs = build(:transfer_attrs, value: 0)
      expected_response = %{value: ["must be greater than 0"]}

      invalid_transfer = Transfer.changeset(invalid_attrs)

      assert errors_on(invalid_transfer) == expected_response
    end
  end
end
