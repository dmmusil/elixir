defmodule ArcadeWeb.TagController do
  use ArcadeWeb, :controller
  alias Arcade.Blog

  def show(conn, %{"tag" => tag} = _params) do
    conn |> assign(:posts, Blog.posts_with_tag(tag)) |> assign(:tag, tag) |> render("by_tag.html")
  end
end
