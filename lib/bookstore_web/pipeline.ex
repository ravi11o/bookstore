defmodule BookstoreWeb.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :bookstore,
                              module: BookstoreWeb.Guardian,
                              error_handler: BookstoreWeb.Api.AuthController

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
end
