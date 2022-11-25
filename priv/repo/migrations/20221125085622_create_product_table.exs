defmodule Embedded.Repo.Migrations.CreateProductTable do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :categories, {:array, :map}, default: []

      timestamps()
    end
  end
end
