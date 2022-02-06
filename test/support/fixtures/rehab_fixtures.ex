defmodule Arcade.RehabFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Arcade.Rehab` context.
  """

  @doc """
  Generate a workout.
  """
  def workout_fixture(attrs \\ %{}) do
    {:ok, workout} =
      attrs
      |> Enum.into(%{
        date: ~D[2022-02-04],
        end_time: ~T[14:02:00.0],
        start_time: ~T[14:02:00.0]
      })
      |> Arcade.Rehab.create_workout()

    workout
  end

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Arcade.Rehab.create_exercise()

    exercise
  end
end
