defmodule Transferex.Transfers.Core.CreateTransfer do
  alias Transferex.Repo
  alias Transferex.Transfers.Data.Transfer

  def execute(transfer) do
    transfer
    |> convert_due_date()
    |> add_status_transfer()
    |> insert_transfer()
  end

  defp convert_due_date(%{"due_date" => due_date} = transfer) do
    case Date.from_iso8601(due_date) do
      {:ok, date} ->
        {:ok, Map.put(transfer, "due_date", date)}

      {:error, :invalid_format} ->
        {:error, {:unprocessable_entity, %{due_date: ["Invalid due_date format"]}}}
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
    changeset = Transfer.changeset(transfer)

    case Repo.insert(changeset) do
      {:ok, transfer} -> {:ok, transfer}
      {:error, changeset} -> {:error, {:unprocessable_entity, changeset}}
    end
  end

  defp insert_transfer({:error, opts}), do: {:error, opts}
end
