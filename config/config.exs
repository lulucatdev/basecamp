# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :basecamp,
  ecto_repos: [Basecamp.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :basecamp, BasecampWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: BasecampWeb.ErrorHTML, json: BasecampWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Basecamp.PubSub,
  live_view: [signing_salt: "+7yqQKfb"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :basecamp, Basecamp.Mailer, adapter: Swoosh.Adapters.Local

# Configure phoenix_vite
config :phoenix_vite, PhoenixVite.Npm,
  assets: [args: [], cd: Path.expand("../assets", __DIR__)],
  vite: [
    args: ~w(exec -- vite),
    cd: Path.expand("../assets", __DIR__),
    env: %{"MIX_BUILD_PATH" => Mix.Project.build_path()}
  ]

# Configure live_vue SSR
config :live_vue, :ssr, true

# Configures Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
