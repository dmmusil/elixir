defmodule ArcadeWeb.WorkoutLive.Index do
  use ArcadeWeb, :live_view

  alias Arcade.Rehab
  alias Arcade.Rehab.Workout

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :workouts, list_workouts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Workout")
    |> assign(:workout, Rehab.get_workout!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Workout")
    |> assign(:workout, %Workout{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Workouts")
    |> assign(:workout, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    workout = Rehab.get_workout!(id)
    {:ok, _} = Rehab.delete_workout(workout)

    {:noreply, assign(socket, :workouts, list_workouts())}
  end

  defp list_workouts do
    Rehab.list_workouts()
  end
end
