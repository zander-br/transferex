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

    test "when there is some error in changeset, returns the error", %{conn: conn} do
      params = build(:transfer_request, %{"value" => 0, "origin_account_id" => "invalid_uuid"})

      response =
        conn
        |> post(Routes.transfers_path(conn, :create), params)
        |> json_response(:unprocessable_entity)

      expected_response = %{
        "errors" => [
          %{"field" => "originAccountId", "message" => "invalid uuid"},
          %{"field" => "value", "message" => "must be greater than 0"}
        ]
      }

      assert expected_response == response
    end

    test "when there is another error, returns the error", %{conn: conn} do
      params = build(:transfer_request, %{"dueDate" => "01/01/2000"})

      response =
        conn
        |> post(Routes.transfers_path(conn, :create), params)
        |> json_response(:unprocessable_entity)

      expected_response = %{"errors" => [%{"field" => "dueDate", "message" => "invalid format"}]}

      assert expected_response == response
    end
  end
end
