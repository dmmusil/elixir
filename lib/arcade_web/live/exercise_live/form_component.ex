defmodule ArcadeWeb.ExerciseLive.FormComponent do
  use ArcadeWeb, :live_component

  alias Arcade.ExerciseCatalog

  @impl true
  def update(%{exercise: exercise} = assigns, socket) do
    changeset = ExerciseCatalog.change_exercise(exercise)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"exercise" => exercise_params}, socket) do
    changeset =
      socket.assigns.exercise
      |> ExerciseCatalog.change_exercise(exercise_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"exercise" => exercise_params}, socket) do
    save_exercise(socket, socket.assigns.action, exercise_params)
  end

  defp save_exercise(socket, :edit, exercise_params) do
    case ExerciseCatalog.update_exercise(socket.assigns.exercise, exercise_params) do
      {:ok, _exercise} ->
        {:noreply,
         socket
         |> put_flash(:info, "Exercise updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_exercise(socket, :new, exercise_params) do
    case ExerciseCatalog.create_exercise(exercise_params) do
      {:ok, _exercise} ->
        {:noreply,
         socket
         |> put_flash(:info, "Exercise created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
