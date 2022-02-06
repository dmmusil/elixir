defmodule Arcade.Repo.Migrations.CreateWorkoutSets do
  use Ecto.Migration

  def change do
    create table(:workout_sets) do
      add :reps, :integer
      add :weight, :integer
      add :workout_exercise_id, references(:workout_exercises, on_delete: :delete_all)

      timestamps()
    end

    create index(:workout_sets, [:workout_exercise_id])
  end
end
