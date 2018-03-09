defmodule Petmeet.Accounts.Follower do
  use Ecto.Schema
  import Ecto.Changeset

  alias Petmeet.Accounts.Pet

  schema "followers" do
    belongs_to :pet, Pet
    belongs_to :follower, Pet, foreign_key: :following_id
    
    timestamps()
  end

  @doc false
  def changeset(follower, attrs) do
    follower
    |> cast(attrs, [:pet_id, :following_id])
    |> validate_required([:pet_id, :following_id])
  end
end
