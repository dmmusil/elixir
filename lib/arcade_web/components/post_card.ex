defmodule ArcadeWeb.PostCard do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <p><a href={"/posts/#{@post.id}"}><%= "#{@post.title} - #{@post.date}" %></a><br />
    <%= for tag <- @post.tags do %>
      <span class="tag"><a href={"/tags/#{tag}"}><i class="bi-tag"></i> <%= tag %></a></span>
    <% end %></p>
    <p><%= @post.description %></p>
    <hr/>
    """
  end
end
