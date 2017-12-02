defmodule Bookstore.Resource.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bookstore.Resource.Author


  schema "authors" do
    field :name, :string
    field :photo, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(%Author{} = author, attrs) do
    author
    |> cast(attrs, [:name, :photo, :slug])
    |> validate_required([:name, :photo, :slug])
    |> unique_constraint(:slug)
  end
end
