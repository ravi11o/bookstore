defmodule Bookstore.Resource do
  import Ecto.Query

  alias Bookstore.Repo
  alias Bookstore.Resource.{Book, Category, Person, BookCategory, Recommendation}


####### Book Queries #############
  def list_books() do
    Book
    |> Repo.all
  end

  def list_books_preloaded() do
    Book
    |> preload([:categories, :persons])
    |> Repo.all
  end

  def get_book(id) do
    Book
    |> Repo.get(id)
  end

  def get_book_preloaded(id) do
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

  def update_book(id, params) do
    Book
    |> Repo.get(id)
    |> Book.changeset(params)
    |> Repo.update
  end

  def update_book_with_categories(categories, book) do
    book
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:categories, categories)
    |> Repo.update!
  end

  def delete_book(id) do
    Book
    |> Repo.get(id)
    |> Repo.delete
  end


####### Person Queries #############
  def list_persons() do
    Person
    |> preload(:books)
    |> Repo.all
  end

  def get_person(id) do
    Person
    |> Repo.get(id)
  end

  def get_person_by_slug(slug) do
    Person
    |> where([p], p.slug == ^slug)
    |> preload(:books)
    |> Repo.one
  end

  def insert_person(params) do
    %Person{}
    |> Person.changeset(params)
    |> Repo.insert
  end

  def update_person(id, params) do
    Person
    |> Repo.get(id)
    |> Person.changeset(params)
    |> Repo.update
  end

  def update_person_with_books(books, person) do
    person
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:books, books)
    |> Repo.update!
  end

  def delete_person(id) do
    Person
    |> Repo.get(id)
    |> Repo.delete
  end




####### Category Queries #############
  def list_categories() do
    Category
    |> Repo.all
  end

  def list_categories_with_books() do
    Category
    |> preload(:books)
    |> Repo.all
  end

  def get_category(id) do
    Category
    |> Repo.get(id)
  end

  def get_category_with_books(id) do
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

  def update_category(id, params) do
    Category
    |> Repo.get(id)
    |> Category.changeset(params)
    |> Repo.update
  end

  def delete_category(id) do
    Category
    |> Repo.get(id)
    |> Repo.delete
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
