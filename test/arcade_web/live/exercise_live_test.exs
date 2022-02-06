defmodule ArcadeWeb.ExerciseLiveTest do
  use ArcadeWeb.ConnCase

  import Phoenix.LiveViewTest
  import Arcade.RehabFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_exercise(_) do
    exercise = exercise_fixture()
    %{exercise: exercise}
  end

  describe "Index" do
    setup [:create_exercise, :register_and_log_in_user]

    test "lists all exercises", %{conn: conn, exercise: exercise} do
      {:ok, _index_live, html} = live(conn, Routes.exercise_index_path(conn, :index))

      assert html =~ "Listing Exercises"
      assert html =~ exercise.name
    end

    test "saves new exercise", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.exercise_index_path(conn, :index))

      assert index_live |> element("a", "New Exercise") |> render_click() =~
               "New Exercise"

      assert_patch(index_live, Routes.exercise_index_path(conn, :new))

      assert index_live
             |> form("#exercise-form", exercise: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#exercise-form", exercise: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.exercise_index_path(conn, :index))

      assert html =~ "Exercise created successfully"
      assert html =~ "some name"
    end

    test "updates exercise in listing", %{conn: conn, exercise: exercise} do
      {:ok, index_live, _html} = live(conn, Routes.exercise_index_path(conn, :index))

      assert index_live |> element("#exercise-#{exercise.id} a", "Edit") |> render_click() =~
               "Edit Exercise"

      assert_patch(index_live, Routes.exercise_index_path(conn, :edit, exercise))

      assert index_live
             |> form("#exercise-form", exercise: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#exercise-form", exercise: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.exercise_index_path(conn, :index))

      assert html =~ "Exercise updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes exercise in listing", %{conn: conn, exercise: exercise} do
      {:ok, index_live, _html} = live(conn, Routes.exercise_index_path(conn, :index))

      assert index_live |> element("#exercise-#{exercise.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#exercise-#{exercise.id}")
    end
  end

  describe "Show" do
    setup [:create_exercise, :register_and_log_in_user]

    test "displays exercise", %{conn: conn, exercise: exercise} do
      {:ok, _show_live, html} = live(conn, Routes.exercise_show_path(conn, :show, exercise))

      assert html =~ "Show Exercise"
      assert html =~ exercise.name
    end

    test "updates exercise within modal", %{conn: conn, exercise: exercise} do
      {:ok, show_live, _html} = live(conn, Routes.exercise_show_path(conn, :show, exercise))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Exercise"

      assert_patch(show_live, Routes.exercise_show_path(conn, :edit, exercise))

      assert show_live
             |> form("#exercise-form", exercise: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#exercise-form", exercise: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.exercise_show_path(conn, :show, exercise))

      assert html =~ "Exercise updated successfully"
      assert html =~ "some updated name"
    end
  end
end
