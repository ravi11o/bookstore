# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bookstore,
  ecto_repos: [Bookstore.Repo]

# Configures the endpoint
config :bookstore, BookstoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE") || "trY/UoDetLnGnVbi6x8xWirjjNhbUScufIqT6BN8dv/0HrjKVq0uZVww5596yN3b",
  render_errors: [view: BookstoreWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bookstore.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Config Guardian
config :bookstore, BookstoreWeb.Guardian,
  issuer: "bookstore",
  ttl: { 30, :days },
  secret_key: "aKb+t27MpCojzsOIGeXZBiXt5CCuV2lhZytn3h4GE3zcvX//FamMwU9ruReFcL2K"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
