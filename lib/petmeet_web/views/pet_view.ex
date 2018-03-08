defmodule PetmeetWeb.PetView do
  use PetmeetWeb, :view
  alias PetmeetWeb.{PetView, PostView, FollowerView}

  def render("index.json", %{pets: pets}) do
    %{data: render_many(pets, PetView, "pet.json")}
  end

  def render("show.json", %{pet: pet}) do
    %{data: render_one(pet, PetView, "pet.json")}
  end

  def render("pet.json", %{pet: pet}) do
    %{id: pet.id,
      name: pet.name,
      breed: pet.breed,
      username: pet.username}
  end
  def render("user_and_token.json", user_and_token) do
    %{data: render_one(user_and_token, PetView, "render_token.json")}
  end

  def render("render_token.json", %{pet: %{pet: pet, token: token, followers: followers, followings: followings}}) do
    %{id: pet.id,
      username: pet.username,
      who_i_follows: render_many(followings, FollowerView, "follower.json"),
      who_follows_me: render_many(followers, FollowerView, "follower.json"),
      posts: render_many(pet.posts, PostView, "own_post.json"),
      meta: %{
        token: token
      }

    }
  end
end
