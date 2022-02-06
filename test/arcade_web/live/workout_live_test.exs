defmodule ArcadeWeb.WorkoutLiveTest do
  use ArcadeWeb.ConnCase

  import Phoenix.LiveViewTest
  import Arcade.RehabFixtures

  @create_attrs %{
    date: ~D[2022-02-04],
    end_time: ~T[14:02:00],
    start_time: ~T[14:02:00]
  }
  @update_attrs %{
    date: ~D[2022-02-04],
    end_time: ~T[14:02:00],
    start_time: ~T[14:02:00]
  }

  defp create_workout(_) do
    workout = workout_fixture()
    %{workout: workout}
  end

  describe "Index" do
    setup [:create_workout, :register_and_log_in_user]

    test "lists all workouts", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.workout_index_path(conn, :index))

      assert html =~ "Listing Workouts"
    end

    test "saves new workout", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.workout_index_path(conn, :index))

      assert index_live |> element("a", "New Workout") |> render_click() =~
               "New Workout"

      assert_patch(index_live, Routes.workout_index_path(conn, :new))

      {:ok, _, html} =
        index_live
        |> form("#workout-form", workout: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.workout_index_path(conn, :index))

      assert html =~ "Workout created successfully"
    end

    test "updates workout in listing", %{conn: conn, workout: workout} do
      {:ok, index_live, _html} = live(conn, Routes.workout_index_path(conn, :index))

      assert index_live |> element("#workout-#{workout.id} a", "Edit") |> render_click() =~
               "Edit Workout"

      assert_patch(index_live, Routes.workout_index_path(conn, :edit, workout))

      {:ok, _, html} =
        index_live
        |> form("#workout-form", workout: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.workout_index_path(conn, :index))

      assert html =~ "Workout updated successfully"
    end

    test "deletes workout in listing", %{conn: conn, workout: workout} do
      {:ok, index_live, _html} = live(conn, Routes.workout_index_path(conn, :index))

      assert index_live |> element("#workout-#{workout.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#workout-#{workout.id}")
    end
  end

  describe "Show" do
    setup [:create_workout, :register_and_log_in_user]

    test "displays workout", %{conn: conn, workout: workout} do
      {:ok, _show_live, html} = live(conn, Routes.workout_show_path(conn, :show, workout))

      assert html =~ "Show Workout"
    end

    test "updates workout within modal", %{conn: conn, workout: workout} do
      {:ok, show_live, _html} = live(conn, Routes.workout_show_path(conn, :show, workout))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Workout"

      assert_patch(show_live, Routes.workout_show_path(conn, :edit, workout))

      {:ok, _, html} =
        show_live
        |> form("#workout-form", workout: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.workout_show_path(conn, :show, workout))

      assert html =~ "Workout updated successfully"
    end
  end
end
