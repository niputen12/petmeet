defmodule PetmeetWeb.FollowerController do
  use PetmeetWeb, :controller

  alias Petmeet.Accounts
  alias Petmeet.Accounts.Follower

  plug PetmeetWeb.Services.Plugs.TokenCheckerPlug

  action_fallback PetmeetWeb.FallbackController

  def index(conn, _params) do
    followers = Accounts.list_followers()
    render(conn, "index.json", followers: followers)
  end

  def create(conn, %{"pet_id" => id}) do
    # check = Accounts.get_follower_id(conn.assigns.pet.id)

    with {:ok, %Follower{} = follower} <- Accounts.create_follower(String.to_integer(id), conn.assigns.pet) do
      conn
      |> put_status(:created)
      |> render("show.json", follower: follower)
    end
  end

  def show(conn, %{"id" => id}) do
    follower = Accounts.get_follower!(id)
    render(conn, "show.json", follower: follower)
  end

  def update(conn, %{"id" => id, "follower" => follower_params}) do
    follower = Accounts.get_follower!(id)

    with {:ok, %Follower{} = follower} <- Accounts.update_follower(follower, follower_params) do
      render(conn, "show.json", follower: follower)
    end
  end

  def delete(conn, %{"id" => id}) do
    follower = Accounts.get_follower!(id)
    with {:ok, %Follower{}} <- Accounts.delete_follower(follower) do
      send_resp(conn, :no_content, "")
    end
  end
end
