defmodule PetmeetWeb.PetControllerTest do
  use PetmeetWeb.ConnCase

  alias Petmeet.Accounts
  alias Petmeet.Accounts.Pet

  @create_attrs %{breed: "some breed", encrypted_password: "some encrypted_password", name: "some name", username: "some username"}
  @update_attrs %{breed: "some updated breed", encrypted_password: "some updated encrypted_password", name: "some updated name", username: "some updated username"}
  @invalid_attrs %{breed: nil, encrypted_password: nil, name: nil, username: nil}

  def fixture(:pet) do
    {:ok, pet} = Accounts.create_pet(@create_attrs)
    pet
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pets", %{conn: conn} do
      conn = get conn, pet_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pet" do
    test "renders pet when data is valid", %{conn: conn} do
      conn = post conn, pet_path(conn, :create), pet: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, pet_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "breed" => "some breed",
        "encrypted_password" => "some encrypted_password",
        "name" => "some name",
        "username" => "some username"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, pet_path(conn, :create), pet: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pet" do
    setup [:create_pet]

    test "renders pet when data is valid", %{conn: conn, pet: %Pet{id: id} = pet} do
      conn = put conn, pet_path(conn, :update, pet), pet: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, pet_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "breed" => "some updated breed",
        "encrypted_password" => "some updated encrypted_password",
        "name" => "some updated name",
        "username" => "some updated username"}
    end

    test "renders errors when data is invalid", %{conn: conn, pet: pet} do
      conn = put conn, pet_path(conn, :update, pet), pet: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pet" do
    setup [:create_pet]

    test "deletes chosen pet", %{conn: conn, pet: pet} do
      conn = delete conn, pet_path(conn, :delete, pet)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, pet_path(conn, :show, pet)
      end
    end
  end

  defp create_pet(_) do
    pet = fixture(:pet)
    {:ok, pet: pet}
  end
end
