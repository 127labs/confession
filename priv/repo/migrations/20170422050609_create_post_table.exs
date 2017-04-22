defmodule Confession.Repo.Migrations.CreatePostTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :message, :string

      timestamps()
    end
  end
end
