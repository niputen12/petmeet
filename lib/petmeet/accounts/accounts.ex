defmodule Petmeet.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Petmeet.Repo

  alias Petmeet.Accounts.Pet
  alias Petmeet.Woofs.Post

  @doc """
  Returns the list of pets.

  ## Examples

      iex> list_pets()
      [%Pet{}, ...]

  """
  def list_pets do
    Repo.all(Pet)
  end

  @doc """
  Gets a single pet.

  Raises `Ecto.NoResultsError` if the Pet does not exist.

  ## Examples

      iex> get_pet!(123)
      %Pet{}

      iex> get_pet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pet!(id), do: Repo.get!(Pet, id)

  @doc """
  Creates a pet.

  ## Examples

      iex> create_pet(%{field: value})
      {:ok, %Pet{}}

      iex> create_pet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pet(attrs \\ %{}) do
    %Pet{}
    |> Pet.changeset(attrs)
    |> Repo.insert()
  end

  def get_pet_by_username(username), do: Repo.get_by!(Pet, username: username) |> Repo.preload(posts: [comments: :pet])


  @doc """
  Updates a pet.

  ## Examples

      iex> update_pet(pet, %{field: new_value})
      {:ok, %Pet{}}

      iex> update_pet(pet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pet(%Pet{} = pet, attrs) do
    pet
    |> Pet.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Pet.

  ## Examples

      iex> delete_pet(pet)
      {:ok, %Pet{}}

      iex> delete_pet(pet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pet(%Pet{} = pet) do
    Repo.delete(pet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pet changes.

  ## Examples

      iex> change_pet(pet)
      %Ecto.Changeset{source: %Pet{}}

  """
  def change_pet(%Pet{} = pet) do
    Pet.changeset(pet, %{})
  end

  alias Petmeet.Accounts.Follower

  @doc """
  Returns the list of followers.

  ## Examples

      iex> list_followers()
      [%Follower{}, ...]

  """
  def list_followers do
    Repo.all(Follower)
  end

  @doc """
  Gets a single follower.

  Raises `Ecto.NoResultsError` if the Follower does not exist.

  ## Examples

      iex> get_follower!(123)
      %Follower{}

      iex> get_follower!(456)
      ** (Ecto.NoResultsError)

  """
  def get_follower!(id), do: Repo.get!(Follower, id)

  @doc """
  Creates a follower.

  ## Examples

      iex> create_follower(%{field: value})
      {:ok, %Follower{}}

      iex> create_follower(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_follower(following_id , follower_id) do
    %Follower {following_id: following_id, user_id: follower_id.id}
    |> Repo.insert()
  end

  def get_following(user_id) do
    Follower
    |> where([f], f.user_id == ^user_id)
    |> Repo.all()
  end

  def get_followers(user_id) do
    Follower
    |> where([f], f.following_id == ^user_id)
    |> Repo.all()
  end

  @doc """
  Updates a follower.

  ## Examples

      iex> update_follower(follower, %{field: new_value})
      {:ok, %Follower{}}

      iex> update_follower(follower, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_follower(%Follower{} = follower, attrs) do
    follower
    |> Follower.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Follower.

  ## Examples

      iex> delete_follower(follower)
      {:ok, %Follower{}}

      iex> delete_follower(follower)
      {:error, %Ecto.Changeset{}}

  """
  def delete_follower(%Follower{} = follower) do
    Repo.delete(follower)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking follower changes.

  ## Examples

      iex> change_follower(follower)
      %Ecto.Changeset{source: %Follower{}}

  """
  def change_follower(%Follower{} = follower) do
    Follower.changeset(follower, %{})
  end
end
