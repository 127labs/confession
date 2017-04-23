# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :confession, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:confession, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :confession,
  ecto_repos: [Confession.Repo],
  fb_verification_token: System.get_env("FB_VERIFICATION_TOKEN"),
  fb_page_access_token: System.get_env("FB_PAGE_ACCESS_TOKEN"),
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :confession, Confession.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("POSTGRES_DATABASE") || "confession_#{Mix.env}",
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  port: "5432"

config :logger, level: :info

import_config "*.secret.exs"
