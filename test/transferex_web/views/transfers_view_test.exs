defmodule TransferexWeb.TransfersViewTest do
  use TransferexWeb.ConnCase, async: true

  alias TransferexWeb.TransfersView

  test "renders create.json" do
    transfer = build(:transfer)

    response = render(TransfersView, "create.json", transfer: transfer)

    assert %{id: transfer.id, status: transfer.status} == response
  end

  test "renders show.json" do
    transfer = build(:transfer)

    response = render(TransfersView, "show.json", transfer: transfer)

    assert %{
             id: transfer.id,
             status: transfer.status,
             destination_account: transfer.destination_account_id,
             due_date: transfer.due_date,
             origin_account: transfer.origin_account_id,
             amount: Decimal.new(100),
             transfer_date: nil,
             liquidation_date: nil,
             liquidation_id: nil
           } == response
  end
end
