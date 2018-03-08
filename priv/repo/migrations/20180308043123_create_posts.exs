defmodule Petmeet.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :body, :text
      add :pet_id, references(:pets, on_delete: :delete_all)

      timestamps()
    end

    create index(:posts, [:pet_id])
  end
end
