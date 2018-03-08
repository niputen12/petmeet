defmodule PetmeetWeb.Router do
  use PetmeetWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PetmeetWeb do
    pipe_through :api

    resources "/pets", PetController, except: [:new, :edit]
    post "/login/auth", PetController, :authenticate
  end
end
