defmodule BookstoreWeb.Api.CategoryController do
  use BookstoreWeb, :controller

  alias Bookstore.Resource

  def index(conn, _params) do
    categories = Resource.list_categories()
    IO.inspect categories
    render conn, "index.json", categories: categories
  end

  def show(conn, %{"category_id" => id}) do
    category = Resource.get_category(id)
    IO.inspect(category)
    render conn, "category.json", category: category
  end
end
