defmodule TransferexWeb.TransfersControllerTest do
  use TransferexWeb.ConnCase, async: true

  describe "create/2" do
    test "when all params is valid, creates the transfer", %{conn: conn} do
      params = build(:transfer_request)

      response =
        conn
        |> post(Routes.transfers_path(conn, :create), params)
        |> json_response(:created)

      assert %{"id" => _id, "status" => "created"} = response
    end
  end
end
