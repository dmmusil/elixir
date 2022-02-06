defmodule ArcadeWeb.WorkoutLive.FormComponent do
  use ArcadeWeb, :live_component

  alias Arcade.Rehab

  @impl true
  def update(%{workout: workout} = assigns, socket) do
    changeset = Rehab.change_workout(workout)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"workout" => workout_params}, socket) do
    changeset =
      socket.assigns.workout
      |> Rehab.change_workout(workout_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"workout" => workout_params}, socket) do
    save_workout(socket, socket.assigns.action, workout_params)
  end

  defp save_workout(socket, :edit, workout_params) do
    case Rehab.update_workout(socket.assigns.workout, workout_params) do
      {:ok, _workout} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workout updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_workout(socket, :new, workout_params) do
    case Rehab.create_workout(workout_params) do
      {:ok, _workout} ->
        {:noreply,
         socket
         |> put_flash(:info, "Workout created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
