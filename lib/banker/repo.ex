defmodule Banker.Repo do
  use Ecto.Repo,
    otp_app: :banker,
    adapter: Ecto.Adapters.Postgres
end
