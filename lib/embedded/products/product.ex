defmodule Embedded.Products.Product do
  use Ecto.Schema

  import Ecto.Changeset

  schema "products" do
    field :name, :string
    embeds_many(:categories, Embedded.Products.Category, on_replace: :delete)
    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name])
    |> cast_embed(:categories, required: true, with: &Embedded.Products.Category.changeset/2)
    |> validate_required([:name])
  end

  def set_categories_changeset(product, categories \\ []) do
    product
    |> put_embed(:categories, categories)
  end
end
