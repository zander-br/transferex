defmodule TransferexWeb.TransfersViewTest do
  use TransferexWeb.ConnCase, async: true

  alias TransferexWeb.TransfersView

  test "renders create.json" do
    transfer = build(:transfer)

    response = render(TransfersView, "create.json", transfer: transfer)

    assert %{id: transfer.id, status: transfer.status} == response
  end
end
