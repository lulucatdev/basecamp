defmodule Basecamp.Repo do
  use Ecto.Repo,
    otp_app: :basecamp,
    adapter: Ecto.Adapters.Postgres
end
