defmodule Arcade.Rehab.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do
    field :date, :date
    field :end_time, :time
    field :start_time, :time

    many_to_many :exercises, Arcade.Rehab.Exercise,
      join_through: "workout_exercises",
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:date, :start_time, :end_time])
    |> validate_required([:date, :start_time, :end_time])
  end
end
