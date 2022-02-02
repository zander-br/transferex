defmodule Transferex.Transfers.Core.CreateTransferTest do
  use Transferex.DataCase, async: true

  alias Transferex.Transfers.Core.CreateTransfer
  alias Transferex.Transfers.Data.Transfer

  describe "execute/1" do
    test "when all params is valid, returns the transfer" do
      valid_transfer = build(:transfer_attrs)

      response = CreateTransfer.execute(valid_transfer)

      assert {:ok, %Transfer{id: _id, inserted_at: _inserted_at, status: :created}} = response
    end
  end
end
