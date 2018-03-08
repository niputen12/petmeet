defmodule Petmeet.Accounts.Follower do
  use Ecto.Schema
  import Ecto.Changeset


  schema "followers" do
    field :following_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(follower, attrs) do
    follower
    |> cast(attrs, [:user_id, :following_id])
    |> validate_required([:user_id, :following_id])
  end
end
