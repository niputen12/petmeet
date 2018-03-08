defmodule Petmeet.Repo.Migrations.CreatePets do
  use Ecto.Migration

  def change do
    create table(:pets) do
      add :name, :string
      add :breed, :string
      add :username, :string
      add :encrypted_password, :text
      add :email, :string

      timestamps()
    end

    create unique_index(:pets, [:email])
    create unique_index(:pets, [:username])
  end
end
