defmodule ArcadeWeb.ExerciseLive.Index do
  use ArcadeWeb, :live_view

  alias Arcade.Rehab
  alias Arcade.Rehab.Exercise

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :exercises, list_exercises())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Exercise")
    |> assign(:exercise, Rehab.get_exercise!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Exercise")
    |> assign(:exercise, %Exercise{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Exercises")
    |> assign(:exercise, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    exercise = Rehab.get_exercise!(id)
    {:ok, _} = Rehab.delete_exercise(exercise)

    {:noreply, assign(socket, :exercises, list_exercises())}
  end

  defp list_exercises do
    Rehab.list_exercises()
  end
end
