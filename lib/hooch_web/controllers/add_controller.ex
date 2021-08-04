defmodule HoochWeb.AddController do
  use HoochWeb, :controller

  alias Hooch.Beer
  alias Hooch.Repo

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def add_beer(conn, params) do
    name = Map.get(params, "name")
    version = Map.get(params, "version")
    type = Map.get(params, "type")
    description = Map.get(params, "description")
    og = Map.get(params, "og")
    fg = Map.get(params, "fg")

    beer = %{
      name: name,
      version: version,
      type: type,
      description: description,
      og: og,
      fg: fg
    }

    {success, data} = Beer.changeset(%Beer{}, beer) |> Repo.insert()

    case success do
      :ok ->
        conn |> json(%{success: true})

      :error ->
        errors = data |> Map.get(:errors) |> Enum.map(&elem(&1, 0))

        conn
        |> json(%{success: false, errors: errors})
    end
  end
end
