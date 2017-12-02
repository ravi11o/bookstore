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
    attrs = Map.merge(attrs, generate_slug(attrs))
    book
    |> cast(attrs, [:name, :author, :slug, :publisher, :description, :affiliate_link, :isbn])
    |> validate_required([:name, :author, :publisher, :description, :affiliate_link])

  end

  defp generate_slug(%{"name" => name}) do
    slug = Slugger.slugify_downcase(name)
    %{"slug" => slug}
  end

end
