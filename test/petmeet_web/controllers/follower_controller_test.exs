defmodule PetmeetWeb.FollowerControllerTest do
  use PetmeetWeb.ConnCase

  alias Petmeet.Accounts
  alias Petmeet.Accounts.Follower

  @create_attrs %{following_id: "some following_id", "user_id,": "some user_id,"}
  @update_attrs %{following_id: "some updated following_id", "user_id,": "some updated user_id,"}
  @invalid_attrs %{following_id: nil, "user_id,": nil}

  def fixture(:follower) do
    {:ok, follower} = Accounts.create_follower(@create_attrs)
    follower
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all followers", %{conn: conn} do
      conn = get conn, follower_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create follower" do
    test "renders follower when data is valid", %{conn: conn} do
      conn = post conn, follower_path(conn, :create), follower: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, follower_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "following_id" => "some following_id",
        "user_id," => "some user_id,"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, follower_path(conn, :create), follower: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update follower" do
    setup [:create_follower]

    test "renders follower when data is valid", %{conn: conn, follower: %Follower{id: id} = follower} do
      conn = put conn, follower_path(conn, :update, follower), follower: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, follower_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "following_id" => "some updated following_id",
        "user_id," => "some updated user_id,"}
    end

    test "renders errors when data is invalid", %{conn: conn, follower: follower} do
      conn = put conn, follower_path(conn, :update, follower), follower: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete follower" do
    setup [:create_follower]

    test "deletes chosen follower", %{conn: conn, follower: follower} do
      conn = delete conn, follower_path(conn, :delete, follower)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, follower_path(conn, :show, follower)
      end
    end
  end

  defp create_follower(_) do
    follower = fixture(:follower)
    {:ok, follower: follower}
  end
end
