defmodule TransferexWeb.ErrorViewTest do
  use TransferexWeb.ConnCase, async: true

  alias Transferex.Transfers.Data.Transfer
  alias TransferexWeb.ErrorView

  describe "render/2" do
    test "render error.json with changeset" do
      invalid_transfer =
        build(:transfer_attrs, %{"amount" => 0, "origin_account_id" => "invalid_uuid"})

      changeset = Transfer.changeset(invalid_transfer)

      expected_response = %{
        errors: [
          %{field: "originAccountId", message: "invalid uuid"},
          %{field: "amount", message: "must be greater than 0"}
        ]
      }

      response = render(ErrorView, "error.json", changeset: changeset)

      assert expected_response == response
    end

    test "render error.json with only error" do
      expected_response = %{
        errors: [
          %{field: "dueDate", message: "invalid format"}
        ]
      }

      response = render(ErrorView, "error.json", error: %{due_date: "invalid format"})

      assert expected_response == response
    end

    test "render error.json with error message" do
      expected_response = %{message: "error message"}

      response = render(ErrorView, "error.json", error: "error message")

      assert expected_response == response
    end
  end
end
