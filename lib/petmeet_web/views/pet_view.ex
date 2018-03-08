defmodule PetmeetWeb.PetView do
  use PetmeetWeb, :view
  alias PetmeetWeb.PetView

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
      username: pet.username,
      encrypted_password: pet.encrypted_password}
  end
  def render("user_and_token.json", user_and_token) do
    %{data: render_one(user_and_token, PetView, "render_token.json")}
  end

  def render("render_token.json", %{pet: %{pet: pet, token: token} }) do
    %{id: pet.id,
      username: pet.username,
      meta: %{
        token: token
      }

    }
  end
end
