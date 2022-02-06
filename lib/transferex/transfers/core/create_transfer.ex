defmodule Transferex.Transfers.Core.CreateTransfer do
  alias Transferex.Transfers.Core.TransferRepo
  alias Transferex.Transfers.Data.Transfer
  alias Transferex.Transfers.Workers.Liquidation, as: LiquidationWorker

  def execute(transfer) do
    transfer
    |> convert_due_date()
    |> add_status_transfer()
    |> insert_transfer()
    |> make_liquidation()
  end

  defp convert_due_date(%{"due_date" => due_date} = transfer) do
    case Date.from_iso8601(due_date) do
      {:ok, date} ->
        {:ok, Map.put(transfer, "due_date", date)}

      {:error, :invalid_format} ->
        {:error, {:unprocessable_entity, %{due_date: "invalid format"}}}
    end
  end

  defp convert_due_date(transfer), do: {:ok, transfer}

  defp add_status_transfer({:ok, %{"due_date" => due_date} = transfer}) do
    now = Date.utc_today()

    case Date.compare(due_date, now) do
      :lt -> {:ok, Map.put(transfer, "status", :rejected)}
      :gt -> {:ok, Map.put(transfer, "status", :scheduled)}
      _ -> {:ok, Map.put(transfer, "status", :created)}
    end
  end

  defp add_status_transfer({:ok, transfer}), do: {:ok, Map.put(transfer, "status", :created)}

  defp add_status_transfer({:error, opts}), do: {:error, opts}

  defp insert_transfer({:ok, transfer}) do
    case TransferRepo.create_transfer(transfer) do
      {:ok, transfer} -> {:ok, transfer}
      {:error, changeset} -> {:error, {:unprocessable_entity, changeset}}
    end
  end

  defp insert_transfer({:error, opts}), do: {:error, opts}

  defp make_liquidation({:ok, %Transfer{status: status} = transfer})
       when status != :rejected do
    create_liquidation_worker(transfer)
    {:ok, transfer}
  end

  defp make_liquidation({:ok, %Transfer{} = transfer}), do: {:ok, transfer}

  defp make_liquidation({:error, opts}), do: {:error, opts}

  defp create_liquidation_worker(%Transfer{id: id, due_date: due_date}) when is_nil(due_date) do
    %{id: id}
    |> LiquidationWorker.new()
    |> Oban.insert()
  end

  defp create_liquidation_worker(%Transfer{id: id, due_date: due_date}) do
    now = Date.utc_today()
    {:ok, standard_time_for_liquidation} = Time.from_iso8601("10:00:00")
    {:ok, scheduled_liquidation} = DateTime.new(due_date, standard_time_for_liquidation)

    case Date.compare(due_date, now) do
      :gt ->
        %{id: id}
        |> LiquidationWorker.new(scheduled_at: scheduled_liquidation)
        |> Oban.insert()

      _ ->
        %{id: id}
        |> LiquidationWorker.new()
        |> Oban.insert()
    end
  end
end
