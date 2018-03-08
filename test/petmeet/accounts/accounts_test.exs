defmodule Petmeet.AccountsTest do
  use Petmeet.DataCase

  alias Petmeet.Accounts

  describe "pets" do
    alias Petmeet.Accounts.Pet

    @valid_attrs %{breed: "some breed", encrypted_password: "some encrypted_password", name: "some name", username: "some username"}
    @update_attrs %{breed: "some updated breed", encrypted_password: "some updated encrypted_password", name: "some updated name", username: "some updated username"}
    @invalid_attrs %{breed: nil, encrypted_password: nil, name: nil, username: nil}

    def pet_fixture(attrs \\ %{}) do
      {:ok, pet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_pet()

      pet
    end

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert Accounts.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert Accounts.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      assert {:ok, %Pet{} = pet} = Accounts.create_pet(@valid_attrs)
      assert pet.breed == "some breed"
      assert pet.encrypted_password == "some encrypted_password"
      assert pet.name == "some name"
      assert pet.username == "some username"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      assert {:ok, pet} = Accounts.update_pet(pet, @update_attrs)
      assert %Pet{} = pet
      assert pet.breed == "some updated breed"
      assert pet.encrypted_password == "some updated encrypted_password"
      assert pet.name == "some updated name"
      assert pet.username == "some updated username"
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_pet(pet, @invalid_attrs)
      assert pet == Accounts.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = Accounts.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = Accounts.change_pet(pet)
    end
  end

  describe "followers" do
    alias Petmeet.Accounts.Follower

    @valid_attrs %{following_id: "some following_id", "user_id,": "some user_id,"}
    @update_attrs %{following_id: "some updated following_id", "user_id,": "some updated user_id,"}
    @invalid_attrs %{following_id: nil, "user_id,": nil}

    def follower_fixture(attrs \\ %{}) do
      {:ok, follower} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_follower()

      follower
    end

    test "list_followers/0 returns all followers" do
      follower = follower_fixture()
      assert Accounts.list_followers() == [follower]
    end

    test "get_follower!/1 returns the follower with given id" do
      follower = follower_fixture()
      assert Accounts.get_follower!(follower.id) == follower
    end

    test "create_follower/1 with valid data creates a follower" do
      assert {:ok, %Follower{} = follower} = Accounts.create_follower(@valid_attrs)
      assert follower.following_id == "some following_id"
      assert follower.user_id, == "some user_id,"
    end

    test "create_follower/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_follower(@invalid_attrs)
    end

    test "update_follower/2 with valid data updates the follower" do
      follower = follower_fixture()
      assert {:ok, follower} = Accounts.update_follower(follower, @update_attrs)
      assert %Follower{} = follower
      assert follower.following_id == "some updated following_id"
      assert follower.user_id, == "some updated user_id,"
    end

    test "update_follower/2 with invalid data returns error changeset" do
      follower = follower_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_follower(follower, @invalid_attrs)
      assert follower == Accounts.get_follower!(follower.id)
    end

    test "delete_follower/1 deletes the follower" do
      follower = follower_fixture()
      assert {:ok, %Follower{}} = Accounts.delete_follower(follower)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_follower!(follower.id) end
    end

    test "change_follower/1 returns a follower changeset" do
      follower = follower_fixture()
      assert %Ecto.Changeset{} = Accounts.change_follower(follower)
    end
  end
end
