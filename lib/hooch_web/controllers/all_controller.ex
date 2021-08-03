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
    |> assign(:all_beers, all_beers)
    |> render("index.html")
  end
end
