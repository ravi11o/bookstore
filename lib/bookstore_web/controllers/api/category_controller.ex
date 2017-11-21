defmodule BookstoreWeb.Api.CategoryController do
  use BookstoreWeb, :controller

  alias Bookstore.Resource
  alias Bookstore.Repo

  def index(conn, _params) do
    categories = Resource.list_categories_with_books()
    render conn, "index.json", categories: categories
  end

  def show(conn, %{"slug" => slug}) do
    category = Resource.get_category_by_slug(slug)
    render conn, "show.json", category: category
  end

  def create(conn, params) do
    with {:ok, category} <- Resource.insert_category(params) do
      category = category |> Repo.preload(:books)
      render conn, "show.json", category: category
    else
      {:error, _changeset} -> json conn, ["This category already exists"]
    end
  end

  def recommended_books(conn, %{"id" => id, "name" => slug}) do
    books  = Resource.select_recommended(id, slug)
    render conn, "only-books.json", books: books
  end
end
