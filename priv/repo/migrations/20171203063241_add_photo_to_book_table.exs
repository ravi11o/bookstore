defmodule Bookstore.Repo.Migrations.AddPhotoToBookTable do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :photo, :string
    end
  end
end
