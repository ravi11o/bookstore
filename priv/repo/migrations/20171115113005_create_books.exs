defmodule Bookstore.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :name, :string
      add :slug, :string
      add :author, :string
      add :publisher, :string
      add :description, :text
      add :afffiliate_link, :string

      timestamps()
    end

    create unique_index(:books, [:slug])
  end
end
