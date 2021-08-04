defmodule Hooch.ActiveBeer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hooch.Repo
  alias Hooch.ActiveBeer

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

  def new(active_beer), do: %ActiveBeer{} |> changeset(active_beer) |> Repo.insert()
  def get(), do: ActiveBeer |> Repo.one()

  def set(id) do
    case ActiveBeer.get() do
      nil -> %ActiveBeer{}
      active_beer -> active_beer
    end
    |> changeset(%{beer_id: id, beer_start: DateTime.utc_now() |> DateTime.to_naive()})
    |> Repo.insert_or_update()
  end
end
