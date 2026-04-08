defmodule App.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string, null: false
      add :description, :text
      add :status, :string, default: "active"

      timestamps(type: :utc_datetime)
    end
  end
end
