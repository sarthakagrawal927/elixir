import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :pheonix_test, PheonixTest.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "pheonix_test_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pheonix_test, PheonixTestWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "J/QPm7qC/cJno/vN1H1a5v4SdEEGkfRxcD21CWQI5j3Iv87icYgBoHwuVKxHhmMI",
  server: false

# In test we don't send emails.
config :pheonix_test, PheonixTest.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
