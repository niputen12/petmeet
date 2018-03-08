defmodule Petmeet.Woofs.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Petmeet.Accounts.Pet
  alias Petmeet.Meows.Comment

  schema "posts" do
    field :body, :string
    belongs_to :pet, Pet
    has_many :comments, Comment
    
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
