ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Transferex.Repo, :manual)

Mox.defmock(Transferex.Transfers.Services.LiquidationMock,
  for: Transferex.Transfers.Behaviours.Liquidation
)
