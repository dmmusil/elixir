defmodule Arcade.RehabTest do
  use Arcade.DataCase

  alias Arcade.Rehab

  describe "workouts" do
    alias Arcade.Rehab.Workout

    import Arcade.RehabFixtures

    @invalid_attrs %{date: nil, end_time: nil, start_time: nil}

    test "list_workouts/0 returns all workouts" do
      workout = workout_fixture()
      assert Rehab.list_workouts() == [workout]
    end

    test "get_workout!/1 returns the workout with given id" do
      workout = workout_fixture()
      assert Rehab.get_workout!(workout.id) == workout
    end

    test "create_workout/1 with valid data creates a workout" do
      valid_attrs = %{
        date: ~D[2022-02-04],
        end_time: ~T[14:02:00],
        start_time: ~T[14:02:00]
      }

      assert {:ok, %Workout{} = workout} = Rehab.create_workout(valid_attrs)
      assert workout.date == ~D[2022-02-04]
      assert workout.end_time == ~T[14:02:00]
      assert workout.start_time == ~T[14:02:00]
    end

    test "create_workout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rehab.create_workout(@invalid_attrs)
    end

    test "update_workout/2 with valid data updates the workout" do
      workout = workout_fixture()

      update_attrs = %{
        date: ~D[2022-02-05],
        end_time: ~T[14:02:00],
        start_time: ~T[14:02:00]
      }

      assert {:ok, %Workout{} = workout} = Rehab.update_workout(workout, update_attrs)
      assert workout.date == ~D[2022-02-05]
      assert workout.end_time == ~T[14:02:00]
      assert workout.start_time == ~T[14:02:00]
    end

    test "update_workout/2 with invalid data returns error changeset" do
      workout = workout_fixture()
      assert {:error, %Ecto.Changeset{}} = Rehab.update_workout(workout, @invalid_attrs)
      assert workout == Rehab.get_workout!(workout.id)
    end

    test "delete_workout/1 deletes the workout" do
      workout = workout_fixture()
      assert {:ok, %Workout{}} = Rehab.delete_workout(workout)
      assert_raise Ecto.NoResultsError, fn -> Rehab.get_workout!(workout.id) end
    end

    test "change_workout/1 returns a workout changeset" do
      workout = workout_fixture()
      assert %Ecto.Changeset{} = Rehab.change_workout(workout)
    end
  end

  describe "exercises" do
    alias Arcade.Rehab.Exercise

    import Arcade.RehabFixtures

    @invalid_attrs %{name: nil}

    test "list_exercises/0 returns all exercises" do
      exercise = exercise_fixture()
      assert Rehab.list_exercises() == [exercise]
    end

    test "get_exercise!/1 returns the exercise with given id" do
      exercise = exercise_fixture()
      assert Rehab.get_exercise!(exercise.id) == exercise
    end

    test "create_exercise/1 with valid data creates a exercise" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Exercise{} = exercise} = Rehab.create_exercise(valid_attrs)
      assert exercise.name == "some name"
    end

    test "create_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rehab.create_exercise(@invalid_attrs)
    end

    test "update_exercise/2 with valid data updates the exercise" do
      exercise = exercise_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Exercise{} = exercise} = Rehab.update_exercise(exercise, update_attrs)

      assert exercise.name == "some updated name"
    end

    test "update_exercise/2 with invalid data returns error changeset" do
      exercise = exercise_fixture()

      assert {:error, %Ecto.Changeset{}} = Rehab.update_exercise(exercise, @invalid_attrs)

      assert exercise == Rehab.get_exercise!(exercise.id)
    end

    test "delete_exercise/1 deletes the exercise" do
      exercise = exercise_fixture()
      assert {:ok, %Exercise{}} = Rehab.delete_exercise(exercise)
      assert_raise Ecto.NoResultsError, fn -> Rehab.get_exercise!(exercise.id) end
    end

    test "change_exercise/1 returns a exercise changeset" do
      exercise = exercise_fixture()
      assert %Ecto.Changeset{} = Rehab.change_exercise(exercise)
    end
  end
end
