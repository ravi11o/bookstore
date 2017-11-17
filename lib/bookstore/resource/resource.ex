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

  def get_book_by_id(id) do
    Book
    |> where([b], b.id == ^id)
    |> preload([:persons, :categories])
    |> Repo.all
  end

  def insert_book(params) do
    changeset =
      %Book{}
      |> Book.changeset(params)
    Repo.insert(changeset)
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
    |> Repo.insert!
  end

  def get_person(id) do
    Repo.get(Person, id)
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
    |> Repo.all
  end
end
