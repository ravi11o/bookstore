defmodule BookstoreWeb.Api.PersonController do
  use BookstoreWeb, :controller

  alias Bookstore.Resource
  alias Bookstore.Repo

  def index(conn, _params) do
    persons = Resource.list_persons()
    render conn, "index.json", persons: persons
  end

  def show(conn, %{"slug" => slug}) do
    person = Resource.get_person_by_slug(slug)
    render conn, "show.json", person: person
  end

  def create(conn, params) do
    with {:ok, person} <- Resource.insert_person(params) do
      person = person |> Repo.preload(:books)
      updated_person =
        if books = Map.get(params, "books") do
            books
            |> Enum.map(fn(id) -> Resource.get_book_preloaded(id) end)
            |> List.flatten
            |> Resource.update_person_with_books(person)
        end
      render conn, "show.json", person: updated_person || person
    else
      {:error, _changeset} -> json conn, ["This person already exists"]
    end
  end

end
