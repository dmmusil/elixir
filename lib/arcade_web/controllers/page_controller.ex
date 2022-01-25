defmodule ArcadeWeb.PageController do
  use ArcadeWeb, :controller
  alias Arcade.Blog

  def index(conn, _params) do
    render(conn |> assign(:posts, Blog.all_posts()), "index.html")
  end
end
