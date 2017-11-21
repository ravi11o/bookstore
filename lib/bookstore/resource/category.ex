defmodule Bookstore.Resource.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bookstore.Resource.{Book, Category, BookCategory}


  schema "categories" do
    field :description, :string
    field :name, :string
    field :slug, :string
    many_to_many :books, Book, join_through: BookCategory, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
    |> generate_slug
  end

  defp generate_slug(changeset) do
    name = get_change(changeset, :name)
    put_change(changeset, :slug, Slugger.slugify_downcase(name))
  end
end
