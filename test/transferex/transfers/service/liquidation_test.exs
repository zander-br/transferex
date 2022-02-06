defmodule Transferex.Transfers.Service.LiquidationTest do
  use Transferex.DataCase, async: true

  alias Plug.Conn
  alias Transferex.Repo
  alias Transferex.Transfers.Data.Transfer
  alias Transferex.Transfers.Service.Liquidation

  describe "execute/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when liquidation is successful, it saves information in the database",
         %{bypass: bypass} do
      id = "ffaa0f75-ede9-4921-81a5-0f898901023d"
      insert(:transfer)
      url = endpoint_url(bypass.port)

      body = ~s({
        "internalId": "192073c5-936e-4343-8070-f02f09bce8ca",
        "status": "APPROVED"
      })

      Bypass.expect(bypass, "POST", "/paymentOrders", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(201, body)
      end)

      Liquidation.execute(url, id)

      transfer = Repo.get(Transfer, id)

      assert %Transfer{
               status: :approved,
               liquidation_id: "192073c5-936e-4343-8070-f02f09bce8ca"
             } = transfer
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end

  describe "create_liquidation_data/1" do
    test "when due_date is not nil, returns liquidation data with expectedOn equals due_date" do
      transfer = build(:transfer, %{due_date: Date.from_iso8601!("2000-12-25")})

      expected_liquidation_data = %{
        "amount" => 100_000,
        "expectedOn" => "25-12-2000",
        "externalId" => "ffaa0f75-ede9-4921-81a5-0f898901023d"
      }

      liquidation_data = Liquidation.create_liquidation_data(transfer)

      assert expected_liquidation_data == liquidation_data
    end
  end
end
