defmodule Hooch.Repo.Migrations.InitialMigration do
  use Ecto.Migration

  def change do
    create table(:beers) do
      add :name, :string
      add :version, :integer
      add :type, :string
      add :description, :string
      add :og, :integer
      add :fg, :integer

      timestamps()
    end

    create table(:tilt_readings) do
      add :beer_id, references(:beers)
      add :color, :string
      add :temp, :integer
      add :gravity, :integer

      timestamps()
    end

    create table(:active_beers) do
      add :beer_id, references(:beers)
      add :beer_start, :naive_datetime

      timestamps()
    end
  end
end
