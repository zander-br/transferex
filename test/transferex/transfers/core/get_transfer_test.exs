defmodule Transferex.Transfers.Core.GetTransferTest do
  use Transferex.DataCase, async: true

  alias Transferex.Transfers.Core.GetTransfer
  alias Transferex.Transfers.Data.Transfer

  describe "by_id/1" do
    test "when there is a transfer with the given id, returns the transfer" do
      id = "ffaa0f75-ede9-4921-81a5-0f898901023d"
      insert(:transfer)

      response = GetTransfer.by_id(id)

      assert {:ok,
              %Transfer{
                id: ^id,
                destination_account_id: "f47a196e-e8a3-4db3-9322-3e4df81b5160",
                origin_account_id: "27287514-5d72-4e79-8d05-df613e3492cc",
                status: :created
              }} = response
    end

    test "when there is no transfer with id, return an error" do
      another_id = "7356b866-2ac6-4373-b455-36dde62484be"
      insert(:transfer)

      response = GetTransfer.by_id(another_id)

      assert {:error, {:not_found, "transfer not found"}} = response
    end
  end
end
