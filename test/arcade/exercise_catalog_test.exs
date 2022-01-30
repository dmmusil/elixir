defmodule Arcade.ExerciseCatalogTest do
  use Arcade.DataCase

  alias Arcade.ExerciseCatalog

  describe "exercises" do
    alias Arcade.ExerciseCatalog.Exercise

    import Arcade.ExerciseCatalogFixtures

    @invalid_attrs %{name: nil}

    test "list_exercises/0 returns all exercises" do
      exercise = exercise_fixture()
      assert ExerciseCatalog.list_exercises() == [exercise]
    end

    test "get_exercise!/1 returns the exercise with given id" do
      exercise = exercise_fixture()
      assert ExerciseCatalog.get_exercise!(exercise.id) == exercise
    end

    test "create_exercise/1 with valid data creates a exercise" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Exercise{} = exercise} = ExerciseCatalog.create_exercise(valid_attrs)
      assert exercise.name == "some name"
    end

    test "create_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ExerciseCatalog.create_exercise(@invalid_attrs)
    end

    test "update_exercise/2 with valid data updates the exercise" do
      exercise = exercise_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Exercise{} = exercise} = ExerciseCatalog.update_exercise(exercise, update_attrs)
      assert exercise.name == "some updated name"
    end

    test "update_exercise/2 with invalid data returns error changeset" do
      exercise = exercise_fixture()
      assert {:error, %Ecto.Changeset{}} = ExerciseCatalog.update_exercise(exercise, @invalid_attrs)
      assert exercise == ExerciseCatalog.get_exercise!(exercise.id)
    end

    test "delete_exercise/1 deletes the exercise" do
      exercise = exercise_fixture()
      assert {:ok, %Exercise{}} = ExerciseCatalog.delete_exercise(exercise)
      assert_raise Ecto.NoResultsError, fn -> ExerciseCatalog.get_exercise!(exercise.id) end
    end

    test "change_exercise/1 returns a exercise changeset" do
      exercise = exercise_fixture()
      assert %Ecto.Changeset{} = ExerciseCatalog.change_exercise(exercise)
    end
  end
end
