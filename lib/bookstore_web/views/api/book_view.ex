defmodule BookstoreWeb.Api.BookView do
  use BookstoreWeb, :view

  def render("book.json", %{book: book}) do
    %{
      id: book.id,
      name: book.name,
      slug: book.slug,
      author: book.author,
      publisher: book.publisher,
      affiliate_link: book.affiliate_link,
      description: book.description,
      categories: render_many(book.categories, __MODULE__, "category.json", as: :category),
      recommendations: render_many(book.persons, __MODULE__, "person.json", as: :person)
    }
  end

  def render("index.json", %{books: books}) do
    %{books: render_many(books, BookstoreWeb.Api.BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{book: render_one(book, __MODULE__, "book.json")}
  end

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name
    }
  end

  def render("person.json", %{person: person}) do
    %{
      id: person.id,
      name: person.name,
      photo: person.photo
    }
  end

end
