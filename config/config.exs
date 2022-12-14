# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :bank_api,
  namespace: BankAPI,
  ecto_repos: [BankAPI.Repo]

# Configures the endpoint
config :bank_api, BankAPIWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BankAPIWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BankAPI.PubSub,
  live_view: [signing_salt: "vzBHlqeZ"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :bank_api, BankAPI.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :bank_api, event_stores: [BankAPI.EventStore]

# Configuration for Commanded
config :bank_api, BankAPI.CommandedApplication,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: BankAPI.EventStore
  ],
  pubsub: :local,
  registry: :local

config :commanded_ecto_projections, repo: BankAPI.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
