defmodule Transferex.Factory do
  use ExMachina.Ecto, repo: Transferex.Repo

  def transfer_attrs_factory do
    %{
      value: 100.00,
      origin_account_id: "b007861e-806d-4580-b705-ac8eff473e2c",
      destination_account_id: "a0868a72-8278-44ee-9125-b4035cdb2e09"
    }
  end
end
