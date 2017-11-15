defmodule Bookstore.Resource.Recommendation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bookstore.Resource.{Book, Person, Recommendation}

  schema "recommendations" do
    belongs_to :book, Book
    belongs_to :person, Person

    timestamps()
  end

  def changeset(%Recommendation{} = recommendation, attrs) do
    recommendation
    |> cast(attrs, [:book_id, :person_id])
    |> validate_required([:book_id, :person_id])
  end
end
