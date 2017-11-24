defmodule Bookstore.Accounts do

  alias Bookstore.Repo
  alias Bookstore.Accounts.Admin

  def get_admin!(id) do
    Admin
    |> Repo.get(id)
  end

  def get_by_email(email) do
    Admin
    |> Repo.get_by(email: email)
  end


end
