import Config

# Configure Bcrypt on tests
config :bcrypt_elixir, :log_rounds, 4

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :consumindo_api, ConsumindoApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "consumindo_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :consumindo_api, ConsumindoApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RYUr8ciQ8Bx2tG0oKwFT1op5eMd4kd79ADJJg6butAdCawJnseXWixKN54QBujiR",
  server: false

# In test we don't send emails.
config :consumindo_api, ConsumindoApi.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
