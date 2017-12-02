defmodule Bookstore.Repo.Migrations.ChangeBookTable do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :isbn, :string
      add :author_id, references(:authors)
    end

    create unique_index(:books, [:isbn])
  end
end
