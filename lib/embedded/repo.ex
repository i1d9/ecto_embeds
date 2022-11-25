defmodule Embedded.Repo do
  use Ecto.Repo,
    otp_app: :embedded,
    adapter: Ecto.Adapters.Postgres
end
