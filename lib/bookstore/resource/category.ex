defmodule Bookstore.Resource.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bookstore.Resource.{Book, Category, BookCategory}


  schema "categories" do
    field :description, :string
    field :name, :string
    many_to_many :books, Book, join_through: BookCategory

    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
