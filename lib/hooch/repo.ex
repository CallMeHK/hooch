defmodule Hooch.Repo do
  use Ecto.Repo,
    otp_app: :hooch,
    adapter: Ecto.Adapters.Postgres
end
