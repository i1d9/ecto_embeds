defmodule Embedded.Products.Category do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:name, :string)
    field(:selected, :boolean, default: false)
    timestamps()
  end

  def changeset(price_quote, attrs \\ %{}) do
    price_quote
    |> cast(attrs, [:name])
  end
end
