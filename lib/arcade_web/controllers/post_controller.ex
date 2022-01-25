defmodule ArcadeWeb.PostController do
  use ArcadeWeb, :controller
  alias Arcade.Blog

  def show(conn, %{"slug" => slug} = _params) do
    render(
      conn |> assign(:post, Blog.all_posts() |> Enum.find(nil, fn p -> p.id == slug end)),
      "show.html"
    )
  end
end
