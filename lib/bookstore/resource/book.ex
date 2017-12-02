defmodule Bookstore.Resource.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bookstore.Resource.{Book, Category, BookCategory, Recommendation, Person}
  @derive {Poison.Encoder, only: [:affiliate_link, :author, :description, :name,
    :publisher, :slug, :categories, :persons]}

  schema "books" do
    field :affiliate_link, :string
    field :author, :string
    field :description, :string
    field :isbn, :string
    field :name, :string
    field :publisher, :string
    field :slug, :string
    many_to_many :categories, Category, join_through: BookCategory, on_replace: :delete, on_delete: :delete_all
    many_to_many :persons, Person, join_through: Recommendation, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Book{} = book, attrs) do
    book
    |> cast(attrs, [:name, :slug, :author, :publisher, :description, :affiliate_link, :isbn])
    |> validate_required([:name, :author, :publisher, :description, :affiliate_link])
    |> unique_constraint(:slug)
    |> generate_slug
  end

  defp generate_slug(changeset) do
    name = get_change(changeset, :name)
    put_change(changeset, :slug, Slugger.slugify_downcase(name))
  end
end
