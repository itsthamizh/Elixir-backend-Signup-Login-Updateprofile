# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :login,
  ecto_repos: [Login.Repo]

# Configures the endpoint
config :login, LoginWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nXBgop+wzeIHFontHk+fMyOlnTYjNw0m3cEvVLhJYvuT/4yQfUsfbJYVCY2Mnb+E",
  render_errors: [view: LoginWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Login.PubSub,
  live_view: [signing_salt: "fRYXo/1Y"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
