defmodule Transferex.Transfers.Behaviours.Liquidation do
  @callback execute(String.t(), String.t()) :: :ok
end
