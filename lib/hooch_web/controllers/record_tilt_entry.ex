defmodule HoochWeb.RecordTiltEntry do
  use HoochWeb, :controller
  alias Hooch.TiltReading
  alias Hooch.ActiveBeer

  def index(conn, %{"color" => color, "temp" => temp, "gravity" => gravity}) do
    IO.inspect(ActiveBeer.get())

    with %{beer_id: active_beer_id} <- ActiveBeer.get(),
         {:ok, _} <-
           TiltReading.new(%{color: color, temp: temp, gravity: gravity, beer_id: active_beer_id}) do
      conn
      |> json(%{success: true})
    else
      _ ->
        conn
        |> json(%{success: false})
    end
  end

  def index(conn, _params) do
    conn
    |> json(%{success: false})
  end
end
