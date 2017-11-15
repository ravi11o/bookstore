defmodule Bookstore.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :name, :string
      add :slug, :string
      add :photo, :string
      add :description, :text

      timestamps()
    end

    create unique_index(:persons, [:slug])
  end
end
