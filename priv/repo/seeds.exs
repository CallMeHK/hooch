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
  alias Hooch.TiltReading
  alias Hooch.Repo

  def seed_beer do
    {:ok, beer1} =
      Beer.new(%{
        name: "beer1",
        version: 1,
        type: "IPA",
        description: "simple ipa 1",
        og: 1060,
        fg: 1010
      })

    {:ok, beer2} =
      Beer.new(%{
        name: "beer2",
        version: 2,
        type: "IPA",
        description: "simple ipa 2",
        og: 1061,
        fg: 1013
      })

    {beer1, beer2}
  end

  def seed_active_beer(beer_id) do
    ActiveBeer.new(%{
      beer_start: ~N[2021-04-01 23:00:07],
      beer_id: beer_id
    })
  end

  def seed_tilt_readings(beer, fg) do
    difference = beer.og - fg

    {:ok, date} = DateTime.from_naive(~N[2021-04-01 23:10:07], "Etc/UTC")

    1..200
    |> Enum.map(fn i ->
      Repo.insert(%TiltReading{
        color: "red",
        temp: 68,
        gravity: round(beer.og - difference * i / 200),
        beer_id: beer.id,
        inserted_at: DateTime.add(date, 60 * 60 * i) |> DateTime.to_naive(),
        updated_at: DateTime.add(date, 60 * 60 * i) |> DateTime.to_naive()
      })
    end)
  end
end

{beer1, beer2} = Hooch.Seed.seed_beer()
Hooch.Seed.seed_active_beer(beer2.id)
Hooch.Seed.seed_tilt_readings(beer1, 1010)
Hooch.Seed.seed_tilt_readings(beer2, 1018)
