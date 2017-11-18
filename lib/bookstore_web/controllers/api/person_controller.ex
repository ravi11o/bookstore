defmodule BookstoreWeb.Api.PersonController do
  use BookstoreWeb, :controller

  alias Bookstore.Resource
  alias Bookstore.Repo

  def index(conn, _params) do
    persons = Resource.list_persons()
    render conn, "index.json", persons: persons
  end

  def show(conn, %{"person_id" => id}) do
    person = Resource.get_person(id)
    render conn, "show.json", person: person
  end

  def create(conn, params) do
    with {:ok, person} <- Resource.insert_person(params) do
      person = person |> Repo.preload(:books)
      if books = Map.get(params, "books") do
        book_list =
          books
          |> Enum.map(fn(id) -> Resource.get_book_by_id(id) end)
          |> List.flatten
        updated_person = Resource.update_person(person, book_list)
      end

      render conn, "show.json", person: updated_person || person
    else
      {:error, _changeset} -> json conn, ["This person already exists"]
    end
  end

end
