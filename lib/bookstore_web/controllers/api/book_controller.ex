defmodule BookstoreWeb.Api.BookController do
  use BookstoreWeb, :controller

  alias Bookstore.Resource
  alias Bookstore.Repo

  def index(conn, _params) do
    books = Resource.list_books_preloaded()
    render conn, "index.json", books: books
  end

  def show(conn, %{"id" => id}) do
    book = Resource.get_book(id)
    render conn, "show.json", book: book
  end

  def show_slug(conn, %{"slug" => slug}) do
    book = Resource.get_book_by_slug(slug)
    render conn, "show.json", book: book
  end

  def create(conn, book_params) do
    with {:ok, book} <-  Resource.insert_book(book_params) do
      book = book |> Repo.preload([:categories, :persons])
      updated_book =
        if categories = Map.get(book_params, "categories") do
            categories
            |> Enum.map(fn(id) -> Resource.get_category_with_books(id) end)
            |> List.flatten
            |> Resource.update_book_with_categories(book)
        end
      render conn, "show_with_category.json", book: updated_book || book
    else
      {:error, _changeset} -> json conn, ["Book with this name already exists"]
    end
  end

  def edit(conn, %{"id" => id}) do
    if book = Resource.get_book(id) do
      book = book |> Repo.preload([:categories, :persons])
      render conn, "edit.json", book: book
    else
      json conn, ["No book with this id found"]
    end

  end

  def update(conn, %{"id" => id} = book_params) do
    with{:ok, book} <- Resource.update_book(id, book_params) do
      book = book |> Repo.preload([:categories, :persons])
      updated_book =
        if categories = Map.get(book_params, "categories") do
            categories
            |> Enum.map(fn(id) -> Resource.get_category_with_books(id) end)
            |> List.flatten
            |> Resource.update_book_with_categories(book)
        end
      render conn, "show_with_category.json", book: updated_book || book
    else
      {:error, _changeset} -> json conn, %{error: "Cannot Update book"}
    end
  end

  def delete(conn, %{"id" => id }) do
    with{:ok, book} <- Resource.delete_book(id) do
      json conn, ["#{book.name} deleted Successfully"]
    else
      {:error, _changeset} -> json conn, ["could not delete book"]
    end
  end



end
