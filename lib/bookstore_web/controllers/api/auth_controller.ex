defmodule BookstoreWeb.Api.AuthController do
  use BookstoreWeb, :controller
  import Comeonin.Bcrypt
  alias Bookstore.Accounts

  def create(conn, %{"email" => email, "password" => password}) do
    admin = Accounts.get_by_email(email)
    cond do
      admin && checkpw(password, admin.hashed_password) ->
        login_admin(conn, admin)
      admin ->
        json conn, "Incorrect Password"
      true ->
        json conn, "Unauthorized"
    end
  end

  def login_admin(conn, admin) do
    {:ok, jwt, _claims} = BookstoreWeb.Guardian.encode_and_sign(admin)
    json conn, %{jwt: jwt}
  end

  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, body)
  end
end
