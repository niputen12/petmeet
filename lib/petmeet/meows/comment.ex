defmodule Petmeet.Meows.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Petmeet.Woofs.Post
  alias Petmeet.Accounts.Pet
  
  schema "comments" do
    field :body, :string
    belongs_to :post, Post
    belongs_to :pet, Pet

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
