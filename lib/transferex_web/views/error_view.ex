defmodule TransferexWeb.ErrorView do
  use TransferexWeb, :view

  alias Ecto.Changeset

  def render("error.json", %{changeset: %Changeset{errors: errors}}) do
    errors =
      Enum.map(errors, fn {field, detail} ->
        %{
          field: Inflex.camelize(field, :lower),
          message: render_detail(detail)
        }
      end)

    %{errors: errors}
  end

  def render("error.json", %{error: error}) when is_map(error) do
    errors =
      Enum.map(error, fn {field, detail} ->
        %{
          field: Inflex.camelize(field, :lower),
          message: render_detail(detail)
        }
      end)

    %{errors: errors}
  end

  def render("error.json", %{error: error}), do: %{message: error}

  defp render_detail({message, values}) do
    Enum.reduce(values, message, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end

  defp render_detail(message) do
    message
  end
end
