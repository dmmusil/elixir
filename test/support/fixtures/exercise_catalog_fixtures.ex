defmodule Arcade.ExerciseCatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Arcade.ExerciseCatalog` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Arcade.ExerciseCatalog.create_exercise()

    exercise
  end
end
