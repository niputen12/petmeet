# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :petmeet,
  ecto_repos: [Petmeet.Repo]

# Configures the endpoint
config :petmeet, PetmeetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kg8lKyzROSFhs6/uniu8hkIz9yX1Tds98vOYX4i/7hz5ULy2dLein7gHjCKPqxQe",
  render_errors: [view: PetmeetWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Petmeet.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
