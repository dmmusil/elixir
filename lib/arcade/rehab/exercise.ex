defmodule Arcade.Rehab.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercises" do
    field :name, :string
    many_to_many :workouts, Arcade.Rehab.Workout, join_through: "workout_exercises"
    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
