defmodule Transferex.Factory do
  use ExMachina.Ecto, repo: Transferex.Repo

  alias Transferex.Transfers.Data.Transfer

  def transfer_attrs_factory do
    %{
      "value" => 100.00,
      "origin_account_id" => "b007861e-806d-4580-b705-ac8eff473e2c",
      "destination_account_id" => "a0868a72-8278-44ee-9125-b4035cdb2e09",
      "status" => :created
    }
  end

  def transfer_request_factory do
    %{
      "value" => 100.20,
      "originAccountId" => "b007861e-806d-4580-b705-ac8eff473e2c",
      "destinationAccountId" => "a0868a72-8278-44ee-9125-b4035cdb2e09"
    }
  end

  def transfer_factory do
    %Transfer{
      destination_account_id: "f47a196e-e8a3-4db3-9322-3e4df81b5160",
      due_date: Date.utc_today(),
      id: "ffaa0f75-ede9-4921-81a5-0f898901023d",
      origin_account_id: "27287514-5d72-4e79-8d05-df613e3492cc",
      status: :created,
      value: Decimal.new(100)
    }
  end
end
