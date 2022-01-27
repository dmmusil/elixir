defmodule ArcadeWeb.PostCard do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <p><a href={"/posts/#{@post.id}"}><%= "#{@post.title} - #{@post.date}" %></a></p>
    <p><%= @post.description %> </p>
    <p>
      <%= for tag <- @post.tags do %>
        <span><a href={"/tags/#{tag}"}><%= tag %></a></span>
      <% end %>
    </p>
    """
  end
end
