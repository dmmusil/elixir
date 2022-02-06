defmodule ArcadeWeb.WorkoutLive.Show do
  use ArcadeWeb, :live_view

  alias Arcade.Rehab

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:workout, Rehab.get_workout!(id))}
  end

  defp page_title(:show), do: "Show Workout"
  defp page_title(:edit), do: "Edit Workout"
end
