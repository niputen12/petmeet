defmodule Petmeet.Repo.Migrations.CreateFollowers do
  use Ecto.Migration

  def change do
    create table(:followers) do
      add :user_id, :bigint
      add :following_id, :bigint

      timestamps()
    end

  end
end
