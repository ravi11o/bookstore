defmodule Bookstore.Resource.Person do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bookstore.Resource.{Person, Book, Recommendation}


  schema "persons" do
    field :description, :string
    field :name, :string
    field :photo, :string
    field :slug, :string
    many_to_many :books, Book, join_through: Recommendation, on_replace: :delete, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Person{} = person, attrs) do
    attrs = Map.merge(attrs, generate_slug(attrs))

    person
    |> cast(attrs, [:name, :slug, :photo, :description])
    |> validate_required([:name, :photo, :description])
    |> unique_constraint(:slug)
  end

  defp generate_slug(%{"name" => name}) do
    slug = Slugger.slugify_downcase(name)
    %{"slug" => slug}
  end
end
