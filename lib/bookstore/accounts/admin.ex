defmodule Bookstore.Accounts.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bookstore.Accounts.Admin


  schema "admins" do
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string

    timestamps()
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> hash_password
  end

  defp hash_password(changeset) do
    pass = get_change(changeset, :password)
    IO.inspect pass
    put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(pass))
  end
end
