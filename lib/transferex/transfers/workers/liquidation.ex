defmodule Transferex.Transfers.Workers.Liquidation do
  use Oban.Worker,
    queue: :default,
    max_attempts: 5

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id}}) do
    liquidation_url = Application.get_env(:transferex, :config)[:liquidation_api_address]
    client().execute(liquidation_url, id)
    :ok
  end

  defp client do
    Application.fetch_env!(:transferex, __MODULE__)[:liquidation_adapter]
  end
end
