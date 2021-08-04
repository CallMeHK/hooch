defmodule HoochWeb.NowController do
  use HoochWeb, :controller
  alias Hooch.ActiveBeer
  alias Hooch.Repo

  def index(conn, _params) do
    %{beer: active_beer} =
      ActiveBeer.get()
      |> Repo.preload(:beer)
      |> Repo.preload(beer: :tilt_readings)

    tilt_readings =
      active_beer.tilt_readings
      |> Enum.map(
        &%{
          gravity: &1.gravity,
          temp: &1.temp,
          time: DateTime.from_naive(&1.inserted_at, "Etc/UTC") |> elem(1) |> DateTime.to_string()
        }
      )

    last_reading =
      List.last(tilt_readings)
      |> case do
        nil -> %{}
        last_elt -> last_elt
      end

    current_gravity = Map.get(last_reading, :gravity, "No readings")
    current_temp = Map.get(last_reading, :temp, "No readings")

    IO.inspect(tilt_readings)

    conn
    |> assign(:current_gravity, current_gravity)
    |> assign(:current_temp, current_temp)
    |> assign(:tilt_readings, tilt_readings)
    |> assign(:beer, active_beer)
    |> render("index.html")
  end
end
