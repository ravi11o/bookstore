defmodule Bookstore.Repo.Migrations.CreateRecommendationTable do
  use Ecto.Migration

  def change do
    create table(:recommendations) do
      add :book_id, references(:books)
      add :person_id, references(:persons)

      timestamps()
    end
  end
end
