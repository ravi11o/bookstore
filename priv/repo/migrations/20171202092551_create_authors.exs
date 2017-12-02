defmodule Bookstore.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string
      add :photo, :string
      add :slug, :string

      timestamps()
    end

    create unique_index(:authors, [:slug])
  end
end
