defmodule BookstoreWeb.Api.CategoryController do
  use BookstoreWeb, :controller

  alias Bookstore.Resource
  alias Bookstore.Repo

  def index(conn, _params) do
    categories = Resource.list_categories()
    render conn, "index.json", categories: categories
  end

  def categories_with_books(conn, _params) do
    categories = Resource.list_categories_with_books()
    render conn, "index_preloaded.json", categories: categories
  end

  def show(conn, %{"id" => id}) do
    category = Resource.get_category(id)
    render conn, "show.json", category: category
  end

  def show_slug(conn, %{"slug" => slug}) do
    category = Resource.get_category_by_slug(slug)
    render conn, "edit.json", category: category
  end

  def create(conn, category_params) do
    with {:ok, category} <- Resource.insert_category(category_params) do
      category = category |> Repo.preload(:books)
      render conn, "show.json", category: category
    else
      {:error, _changeset} -> json conn, ["This category already exists"]
    end
  end

  def edit(conn, %{"id" => id}) do
    if category = Resource.get_category(id) do
      category = category |> Repo.preload(:books)
      render conn, "edit.json", category: category
    else
      json conn, "No category with this id found"
    end

  end

  def update(conn, %{"id" => id} = category_params) do
    with{:ok, category} <- Resource.update_category(id, category_params) do
      render conn, "show.json", category: category
    else
      {:error, _changeset} -> json conn, ["Category Update failed"]
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, category} <- Resource.delete_category(id) do
      json conn, "#{category.name} deleted successfully."
    else
      {:error, _changeset} -> json conn, "Could not delete category."
    end
  end

  def recommended_books(conn, %{"id" => id, "name" => slug}) do
    books  = Resource.select_recommended(id, slug)
    render conn, "only-books.json", books: books
  end
end
