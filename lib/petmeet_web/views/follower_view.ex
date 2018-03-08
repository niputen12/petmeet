defmodule PetmeetWeb.FollowerView do
  use PetmeetWeb, :view
  alias PetmeetWeb.FollowerView

  def render("index.json", %{followers: followers}) do
    %{data: render_many(followers, FollowerView, "follower.json")}
  end

  def render("show.json", %{follower: follower}) do
    %{data: render_one(follower, FollowerView, "follower.json")}
  end

  def render("follower.json", %{follower: follower}) do
    %{id: follower.id,
      user_id: follower.user_id,
      following_id: follower.following_id}
  end
end
