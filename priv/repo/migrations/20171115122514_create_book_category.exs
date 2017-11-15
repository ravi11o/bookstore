defmodule Bookstore.Repo.Migrations.CreateBookCategory do
  use Ecto.Migration

  def change do
    create table(:books_categories) do
      add :book_id, references(:books)
      add :category_id, references(:categories)

      timestamps()
    end
  end
end
