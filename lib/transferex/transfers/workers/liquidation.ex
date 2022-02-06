defmodule Transferex.Transfers.Workers.Liquidation do
  use Oban.Worker,
    queue: :default,
    max_attempts: 5

  alias Transferex.Transfers.Service.Liquidation

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id}}) do
    liquidation_url = "http://localhost:3333"
    Liquidation.execute(liquidation_url, id)
    :ok
  end
end
