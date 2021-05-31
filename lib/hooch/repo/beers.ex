defmodule Hooch.Beer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hooch.Repo

  schema "beers" do
    field(:name, :string)
    field(:version, :integer)
    field(:type, :string)
    field(:description, :string)
    field(:og, :integer)
    field(:fg, :integer)

    timestamps()

    has_many(:tilt_readings, Hooch.TiltReading)
  end

  def changeset(beer, attrs) do
    beer
    |> cast(attrs, [:name, :version, :type, :description, :og, :fg])
    |> validate_required([:name, :version, :type, :og, :fg])
  end

  def new(beer), do: %Hooch.Beer{} |> changeset(beer) |> Repo.insert()
end
