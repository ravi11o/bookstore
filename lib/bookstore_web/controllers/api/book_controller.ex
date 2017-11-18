defmodule BookstoreWeb.Api.BookController do
  use BookstoreWeb, :controller

  alias Bookstore.Resource
  alias Bookstore.Repo

  def index(conn, _params) do
    books = Resource.list_books()
    render conn, "index.json", books: books
  end

  def create(conn, params) do
    with {:ok, book} <-  Resource.insert_book(params) do
      book = book |> Repo.preload([:categories, :persons])
      if categories = Map.get(params, "categories") do
        categories_list =
          categories
          |> Enum.map(fn(id) -> Resource.get_category(id) end)
          |> List.flatten

        updated_book = Resource.update_book(book, categories_list)
      end
      render conn, "show.json", book: updated_book || book
    else
      {:error, _changeset} -> json conn, ["Book with this name already exists"]
    end


  end

  def show(conn, %{"slug" => slug}) do
    book = Resource.get_book_by_slug(slug)
    render conn, "show.json", book: book
  end

end
