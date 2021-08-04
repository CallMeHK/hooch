defmodule HoochWeb.AllController do
  use HoochWeb, :controller

  alias Hooch.Beer
  alias Hooch.ActiveBeer

  def index(conn, _params) do
    active_beer_id = ActiveBeer.get() |> Map.get(:beer_id)

    all_beers =
      case Beer.all() do
        [] ->
          []

        beers ->
          beers
          |> Enum.map(&Map.merge(&1, %{active: &1.id == active_beer_id}))
      end

    IO.inspect(all_beers)

    conn
    |> assign(:active_beer_id, active_beer_id)
    |> assign(:all_beers, all_beers)
    |> render("index.html")
  end

  def set_active(conn, params) do
    id = Map.get(params, "id")

    new_active_beer = ActiveBeer.set(id)

    IO.inspect(new_active_beer)

    conn
    |> json(%{success: true})
  end
end
