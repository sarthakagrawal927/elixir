defmodule PheonixTest.Repo.Migrations.CreateQuotations do
  use Ecto.Migration

  def change do
    create table(:quotations) do
      add :author, :string
      add :text, :text

      timestamps()
    end
  end
end
