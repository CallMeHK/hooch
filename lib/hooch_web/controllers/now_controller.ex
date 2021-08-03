defmodule HoochWeb.NowController do
  use HoochWeb, :controller
  alias Hooch.ActiveBeer
  alias Hooch.Repo

  def index(conn, _params) do
    %{beer: active_beer} =
      ActiveBeer.get()
      |> Repo.preload(:beer)
      |> Repo.preload(beer: :tilt_readings)

    conn
    |> assign(:beer, active_beer)
    |> render("index.html")
  end
end
