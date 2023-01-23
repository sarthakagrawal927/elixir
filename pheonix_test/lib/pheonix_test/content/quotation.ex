defmodule PheonixTest.Content.Quotation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotations" do
    field :author, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(quotation, attrs) do
    quotation
    |> cast(attrs, [:author, :text])
    |> validate_required([:author, :text])
  end
end
