defmodule BookstoreWeb.Api.PersonController do
  use BookstoreWeb, :controller

  alias Bookstore.Resource
  alias Bookstore.Repo

  def index(conn, _params) do
    persons = Resource.list_persons()
    render conn, "index.json", persons: persons
  end

  def create(conn, params) do
    person = Resource.insert_person(params)
    person = person |> Repo.preload(:books)
    if books = Map.get(params, "books") do
      book_list =
        books
        |> Enum.map(fn(id) -> Resource.get_book_by_id(id) end)
        |> List.flatten
    end
    updated_person = Resource.update_person(person, book_list)
    
    render conn, "show.json", person: updated_person || person
  end
end
