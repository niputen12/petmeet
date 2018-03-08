defmodule PetmeetWeb.PetController do
  use PetmeetWeb, :controller

  alias Petmeet.Accounts
  alias Petmeet.Accounts.Pet
  alias PetmeetWeb.Services.Authenticator

  action_fallback PetmeetWeb.FallbackController

  def index(conn, _params) do
    pets = Accounts.list_pets()
    render(conn, "index.json", pets: pets)
  end

  def create(conn, %{"pet" => pet_params}) do
    with {:ok, %Pet{} = pet} <- Accounts.create_pet(pet_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", pet_path(conn, :show, pet))
      |> render("show.json", pet: pet)
    end
  end

  def show(conn, %{"id" => id}) do
    pet = Accounts.get_pet!(id)
    render(conn, "show.json", pet: pet)
  end

  def update(conn, %{"id" => id, "pet" => pet_params}) do
    pet = Accounts.get_pet!(id)

    with {:ok, %Pet{} = pet} <- Accounts.update_pet(pet, pet_params) do
      render(conn, "show.json", pet: pet)
    end
  end

  def delete(conn, %{"id" => id}) do
    pet = Accounts.get_pet!(id)
    with {:ok, %Pet{}} <- Accounts.delete_pet(pet) do
      send_resp(conn, :no_content, "")
    end
  end

  def authenticate(conn, %{"username" => username, "password" => password}) do
    case Authenticator.authenticate(username, password) do
      {:ok, user_and_token} ->
        render(conn, "user_and_token.json", user_and_token)
      {:error, lol} ->
        conn
          |> put_status(:unauthorized)
          |> put_view(PetmeetWeb.CustomErrorView)
          |> render("errors.json", %{
             errors: [
               %{
                 title: "unauthorized",
                 detail: lol
               }
             ]
           })
          |> halt()
    end

  end
end
