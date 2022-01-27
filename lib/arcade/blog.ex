defmodule Arcade.Blog do
  alias Arcade.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:arcade, "priv/posts/**/*.md"),
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  # The @posts variable is first defined by NimblePublisher.
  # Let's further modify it by sorting all posts by descending date.
  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  # Let's also get all tags
  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  # And finally export them
  def all_posts, do: @posts
  def all_tags, do: @tags

  def posts_with_tag(tag),
    do: all_posts() |> Enum.filter(fn post -> post.tags |> Enum.any?(&(&1 == tag)) end)
end
