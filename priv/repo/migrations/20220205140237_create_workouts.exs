defmodule Arcade.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :date, :date
      add :start_time, :time
      add :end_time, :time

      timestamps()
    end
  end
end
