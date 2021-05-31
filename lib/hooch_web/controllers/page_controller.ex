defmodule HoochWeb.PageController do
  use HoochWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
