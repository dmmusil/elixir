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
    |> cast(attrs, [])
    |> validate_required([])
  end
end
