defmodule Bookstore.Resource do
  import Ecto.Query

  alias Bookstore.Repo
  alias Bookstore.Resource.{Book, Category, Person}


####### Book Queries #############
  def list_books() do
    Book
    |> preload([:categories, :persons])
    |> Repo.all
  end

  def get_book(id) do
    Book
    |> where([b], b.id == ^id)
    |> preload([:persons, :categories])
    |> Repo.one
  end

  def get_book_by_slug(slug) do
    Book
    |> where([b], b.slug == ^slug)
    |> preload([:persons, :categories])
    |> Repo.one
  end

  def insert_book(params) do
      %Book{}
      |> Book.changeset(params)
      |> Repo.insert
  end

  def update_book(book, categories) do
    book
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:categories, categories)
    |> Repo.update!
  end


####### Person Queries #############
  def list_persons() do
    Person
    |> preload(:books)
    |> Repo.all
  end

  def insert_person(params) do
    %Person{}
    |> Person.changeset(params)
    |> Repo.insert
  end

  def get_person_by_slug(slug) do
    Person
    |> where([p], p.slug == ^slug)
    |> preload(:books)
    |> Repo.one
  end

  def update_person(person, books) do
    person
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:books, books)
    |> Repo.update!
  end




####### Category Queries #############
  def list_categories() do
    Category
    |> preload(:books)
    |> Repo.all
  end

  def get_category(id) do
    Category
    |> where([c], c.id == ^id)
    |> preload(:books)
    |> Repo.one
  end

  def get_category_by_slug(slug) do
    Category
    |> where([c], c.slug == ^slug)
    |> preload(:books)
    |> Repo.one
  end

  def insert_category(params) do
    %Category{}
    |> Category.changeset(params)
    |> Repo.insert
  end
end
