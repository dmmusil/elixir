defmodule ArcadeWeb.ExerciseLive.Show do
  use ArcadeWeb, :live_view

  alias Arcade.ExerciseCatalog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:exercise, ExerciseCatalog.get_exercise!(id))}
  end

  defp page_title(:show), do: "Show Exercise"
  defp page_title(:edit), do: "Edit Exercise"
end
