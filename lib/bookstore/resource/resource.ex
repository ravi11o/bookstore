defmodule Bookstore.Resource do
  import Ecto.Query

  alias Bookstore.Repo
  alias Bookstore.Resource.{Book, Category, Person, BookCategory, Recommendation}


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

  def select_recommended(id, slug) do
    query =
      from b in Book,
      select: [:id, :name, :author, :description, :publisher],
      join: bc in BookCategory, where: bc.book_id == b.id,
      join: c in Category, where: c.id == bc.category_id,
      join: r in Recommendation, where: r.book_id == b.id,
      join: p in Person, where: p.id == r.person_id,
      where: c.id == ^id and p.slug == ^slug
    Repo.all(query)
  end
end
