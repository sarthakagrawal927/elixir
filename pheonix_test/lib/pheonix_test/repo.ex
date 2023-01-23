defmodule PheonixTest.Repo do
  use Ecto.Repo,
    otp_app: :pheonix_test,
    adapter: Ecto.Adapters.Postgres
end
