defmodule Arcade.Repo.Migrations.CreateWorkoutExercises do
  use Ecto.Migration

  def change do
    create table(:workout_exercises) do
      add :exercise_id, references(:exercises, on_delete: :nothing)
      add :workout_id, references(:workouts, on_delete: :nothing)

      timestamps()
    end

    create index(:workout_exercises, [:exercise_id])
    create index(:workout_exercises, [:workout_id])
  end
end
