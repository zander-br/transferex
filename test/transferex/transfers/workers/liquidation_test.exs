defmodule Transferex.Transfers.Workers.LiquidationTest do
  use Transferex.DataCase, async: true

  import Mox

  alias Transferex.Transfers.Services.LiquidationMock
  alias Transferex.Transfers.Workers.Liquidation, as: LiquidationWorker

  describe "perform/1" do
    test "when worker is successful, it returns :ok" do
      id = "ffaa0f75-ede9-4921-81a5-0f898901023d"
      insert(:transfer)

      expect(LiquidationMock, :execute, fn _url, _id ->
        :ok
      end)

      assert :ok = perform_job(LiquidationWorker, %{"id" => id})
    end
  end
end
