defmodule Arcade.Rehab.WorkoutExercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workout_exercises" do
    field :exercise_id, :id
    field :workout_id, :id

    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:workout_id, :exercise_id])
    |> validate_required([:workout_id, :exercise_id])
  end
end
