defmodule Arcade.Rehab.Set do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workout_sets" do
    field :reps, :integer
    field :weight, :integer
    field :workout_exercise_id, :id
    belongs_to :exercise, Arcade.Rehab.WorkoutExercise
    timestamps()
  end

  @doc false
  def changeset(set, attrs) do
    set
    |> cast(attrs, [:reps, :weight])
    |> validate_required([:reps, :weight])
  end
end
