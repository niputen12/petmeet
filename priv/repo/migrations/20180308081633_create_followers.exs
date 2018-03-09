defmodule Petmeet.Repo.Migrations.CreateFollowers do
  use Ecto.Migration

  def change do
    create table(:followers) do
      # add :pet_id, references(:pets, on_delete: :nothing)
      # add :followings_id, :integer

      add :pet_id, references(:pets, on_delete: :nothing)
      add :following_id, references(:pets, on_delete: :nothing)

      timestamps()
    end

  end
end
