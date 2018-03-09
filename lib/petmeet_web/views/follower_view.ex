defmodule PetmeetWeb.FollowerView do
  use PetmeetWeb, :view
  alias PetmeetWeb.{FollowerView, PetView}

  def render("index.json", %{followers: followers}) do
    %{data: render_many(followers, FollowerView, "follower.json")}
  end

  def render("show.json", %{follower: follower}) do
    %{data: render_one(follower, FollowerView, "follower.json")}
  end

  def render("follower.json", %{follower: follower}) do
    %{id: follower.id,
      following_id: follower.following_id
    }
  end

  def render("followers.json", %{follower: follower}) do
    %{id: follower.id,
      following_id: follower.following_id,
      name: render_one(follower.follower, PetView, "pet.json")
    }
  end
end
