defmodule ArcadeWeb.Blog.Components do
  use Phoenix.Component

  def post_card(assigns) do
    ~H"""
    <p><a href={"/posts/#{@post.id}"}><%= "#{@post.title} - #{@post.date}" %></a><br />
    <%= for tag <- @post.tags do %>
      <.tag tag={tag} />
    <% end %></p>
    <p><%= @post.description %></p>
    <hr/>
    """
  end

  def tag(assigns) do
    ~H"""
    <span class="tag"><a href={"/tags/#{@tag}"}><i class="bi-tag"></i> <%= @tag %></a></span>
    """
  end
end
