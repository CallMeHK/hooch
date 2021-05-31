# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hooch.Repo.insert!(%Hooch.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Hooch.Seed do
  alias Hooch.Beer
  alias Hooch.ActiveBeer

  def seed_beer do
    Beer.new(%{
      name: "beer1",
      version: 1,
      type: "IPA",
      description: "simple ipa 1",
      og: 1060,
      fg: 1010
    })

    Beer.new(%{
      name: "beer2",
      version: 2,
      type: "IPA",
      description: "simple ipa 2",
      og: 1061,
      fg: 1013
    })
  end

  def seed_active_beer(beer_id) do
    ActiveBeer.new(%{
      beer_start: ~N[2021-04-01 23:00:07],
      beer_id: beer_id
    })
  end
end

{:ok, %{id: id}} = Hooch.Seed.seed_beer()
Hooch.Seed.seed_active_beer(id)
