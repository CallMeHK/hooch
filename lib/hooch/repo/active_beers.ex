defmodule Hooch.ActiveBeer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hooch.Repo

  schema "active_beers" do
    field(:beer_start, :naive_datetime)

    timestamps()

    belongs_to(:beer, Hooch.Beer, foreign_key: :beer_id)
  end

  def changeset(active_beer, attrs) do
    active_beer
    |> cast(attrs, [:beer_start, :beer_id])
    |> validate_required([:beer_start, :beer_id])
  end

  def new(active_beer), do: %Hooch.ActiveBeer{} |> changeset(active_beer) |> Repo.insert()
  def get(), do: Hooch.ActiveBeer |> Repo.one()
end
