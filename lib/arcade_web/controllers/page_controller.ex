defmodule ArcadeWeb.PageController do
  use ArcadeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
