defmodule Petmeet.Accounts.Pet do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt
  alias Petmeet.Woofs.Post
  alias Petmeet.Meows.Comment
  
  schema "pets" do
    field :breed, :string
    field :encrypted_password, :string
    field :name, :string
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    has_many :posts, Post
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name, :breed, :username, :email, :password])
    |> validate_required([:name, :breed, :username, :email, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> encrypted_password()
  end

  def update_changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name, :breed, :username])
    |> validate_required([:name, :breed, :username])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  defp encrypted_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, add_hash(password, hash_key: :encrypted_password))
  end
  defp encrypted_password(changeset), do: changeset
end
