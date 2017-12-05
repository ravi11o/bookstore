defmodule BookstoreWeb.Api.PersonView do
  use BookstoreWeb, :view

  def render("person.json", %{person: person}) do
    %{
      id: person.id,
      name: person.name,
      photo: person.photo,
      slug: person.slug,
      description: person.description,
      books: render_many(person.books, __MODULE__, "book.json", as: :book)
    }
  end

  def render("only-person.json", %{person: person}) do
    %{
      id: person.id,
      name: person.name,
      photo: person.photo,
      slug: person.slug,
      description: person.description
    }
  end

  def render("index.json", %{persons: persons}) do
    %{persons: render_many(persons, __MODULE__, "only-person.json")}
  end

  def render("index_preloaded.json", %{persons: persons}) do
    %{persons: render_many(persons, __MODULE__, "person.json")}
  end

  def render("show.json", %{person: person}) do
    %{person: render_one(person, __MODULE__, "only-person.json")}
  end

  def render("show_with_books.json", %{person: person}) do
    %{person: render_one(person, __MODULE__, "person.json")}
  end

  def render("edit.json", %{person: person}) do
    %{
      person: render_one(person, __MODULE__, "person.json")
    }
  end

  def render("book.json", %{book: book}) do
    %{
      id: book.id,
      name: book.name,
      author: book.author,
      photo: book.photo
    }
  end
end
