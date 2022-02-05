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
      params = build(:transfer_request, %{"amount" => 0, "origin_account_id" => "invalid_uuid"})

      response =
        conn
        |> post(Routes.transfers_path(conn, :create), params)
        |> json_response(:unprocessable_entity)

      expected_response = %{
        "errors" => [
          %{"field" => "originAccountId", "message" => "invalid uuid"},
          %{"field" => "amount", "message" => "must be greater than 0"}
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

  describe "show/2" do
    setup %{conn: conn} do
      insert(:transfer)

      {:ok, conn: conn}
    end

    test "when there is a transfer with the given id, returns the transfer", %{conn: conn} do
      id = "ffaa0f75-ede9-4921-81a5-0f898901023d"

      response =
        conn
        |> get(Routes.transfers_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "amount" => "100",
               "destinationAccount" => "f47a196e-e8a3-4db3-9322-3e4df81b5160",
               "originAccount" => "27287514-5d72-4e79-8d05-df613e3492cc",
               "status" => "created"
             } = response
    end
  end
end
