defmodule Hooch.TiltReading do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hooch.Repo

  schema "tilt_readings" do
    field(:color, :string)
    field(:temp, :integer)
    field(:gravity, :integer)

    timestamps()

    belongs_to(:beer, Hooch.Beer, foreign_key: :beer_id)
  end

  def changeset(reading, attrs) do
    reading
    |> cast(attrs, [:color, :temp, :gravity, :beer_id])
    |> validate_required([:color, :temp, :gravity, :beer_id])
  end

  def new(reading),
    do: %Hooch.TiltReading{} |> Hooch.TiltReading.changeset(reading) |> Repo.insert()
end
