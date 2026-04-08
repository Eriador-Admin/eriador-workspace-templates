defmodule AppWeb.ItemController do
  use Phoenix.Controller, formats: [:json]

  alias App.{Repo, Item}
  import Ecto.Query

  action_fallback AppWeb.FallbackController

  def health(conn, _params) do
    json(conn, %{status: "ok"})
  end

  def index(conn, _params) do
    items = Repo.all(from i in Item, order_by: [desc: i.inserted_at])
    json(conn, %{data: Enum.map(items, &item_json/1)})
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Item, id) do
      nil -> {:error, :not_found}
      item -> json(conn, %{data: item_json(item)})
    end
  end

  def create(conn, %{"item" => item_params}) do
    changeset = Item.changeset(%Item{}, item_params)

    case Repo.insert(changeset) do
      {:ok, item} ->
        conn
        |> put_status(:created)
        |> json(%{data: item_json(item)})

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    case Repo.get(Item, id) do
      nil ->
        {:error, :not_found}

      item ->
        changeset = Item.changeset(item, item_params)

        case Repo.update(changeset) do
          {:ok, updated} -> json(conn, %{data: item_json(updated)})
          {:error, changeset} -> {:error, changeset}
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.get(Item, id) do
      nil ->
        {:error, :not_found}

      item ->
        Repo.delete!(item)
        send_resp(conn, :no_content, "")
    end
  end

  defp item_json(item) do
    %{
      id: item.id,
      name: item.name,
      description: item.description,
      status: item.status,
      inserted_at: item.inserted_at,
      updated_at: item.updated_at
    }
  end
end
