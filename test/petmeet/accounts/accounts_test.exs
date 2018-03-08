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
end
