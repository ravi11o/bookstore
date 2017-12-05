defmodule BookstoreWeb.Api.CategoryView do
  use BookstoreWeb, :view

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name,
      slug: category.slug,
      description: category.description,
      books: render_many(category.books, __MODULE__, "book.json", as: :book)
    }
  end

  def render("only-category.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name,
      slug: category.slug,
      description: category.description
    }
  end

  def render("index.json", %{categories: categories}) do
    %{categories: render_many(categories, __MODULE__, "only-category.json")}
  end

  def render("index_preloaded.json", %{categories: categories}) do
    %{categories: render_many(categories, __MODULE__, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{category: render_one(category, __MODULE__, "only-category.json")}
  end

  def render("edit.json", %{category: category}) do
    %{category: render_one(category, __MODULE__, "category.json")}
  end

  def render("only-books.json", %{books: books}) do
    %{books: render_many(books, __MODULE__, "book.json", as: :book)}
  end

  def render("book.json", %{book: book}) do
    %{
      id: book.id,
      name: book.name,
      author: book.author,
      description: book.description,
      publisher: book.publisher,
      photo: book.photo
    }
  end
end
