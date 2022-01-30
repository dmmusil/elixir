defmodule ArcadeWeb.PageController do
  use ArcadeWeb, :controller
  alias Arcade.Blog

  def index(conn, _params) do
    render(conn, "index.html", posts: Blog.all_posts(), tags: Blog.all_tags())
  end
end
