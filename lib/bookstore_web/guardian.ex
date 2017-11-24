defmodule BookstoreWeb.Guardian do
  use Guardian, otp_app: :bookstore

  alias Bookstore.Accounts

  def subject_for_token(admin, _claims) do
    {:ok, to_string(admin.id)}
  end

  def resource_from_claims(claims) do
    admin = claims["sub"]
    |> Accounts.get_admin!
    {:ok, admin}
  end


end
