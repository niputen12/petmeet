defmodule PetmeetWeb.Router do
  use PetmeetWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PetmeetWeb do
    pipe_through :api

    resources "/pets", PetController, except: [:new, :edit] do
      post "/follow", FollowerController, :create
    end
    post "/login/auth", PetController, :authenticate
    resources "/posts", PostController, except: [:new, :edit] do
      resources "/comments", CommentController, except: [:new, :edit]
    end

  end
end
