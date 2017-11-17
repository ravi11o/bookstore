defmodule BookstoreWeb.Api.CategoryView do
  use BookstoreWeb, :view

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name,
      description: category.description,
      books: render_many(category.books, __MODULE__, "book.json", as: :book)
    }
  end

  def render("index.json", %{categories: categories}) do
    %{categories: render_many(categories, __MODULE__, "category.json", as: :category)}
  end

  def render("show.json", %{category: category}) do
    %{category: render_one(category, __MODULE__, "category.json", as: :category)}
  end

  def render("book.json", %{book: book}) do
    %{
      id: book.id,
      name: book.name
    }
  end
end
