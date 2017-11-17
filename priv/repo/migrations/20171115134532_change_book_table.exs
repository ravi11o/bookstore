defmodule Bookstore.Repo.Migrations.ChangeBookTable do
  use Ecto.Migration

  def change do
    rename table(:books), :afffiliate_link, to: :affiliate_link
  end
end
