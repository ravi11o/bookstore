defmodule Bookstore.Resource.BookCategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bookstore.Resource.{Book, Category, BookCategory}

  schema "books_categories" do
    belongs_to :book, Book
    belongs_to :category, Category

    timestamps()
  end

  def changeset(%BookCategory{} = book_category, attrs) do
    book_category
    |> cast(attrs, [:book_id, :category_id])
    |> validate_required([:book_id, :category_id])
  end
end
