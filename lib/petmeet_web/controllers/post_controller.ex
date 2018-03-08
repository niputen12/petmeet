defmodule PetmeetWeb.PostController do
  use PetmeetWeb, :controller

  alias Petmeet.Woofs
  alias Petmeet.Woofs.Post

  plug PetmeetWeb.Services.Plugs.TokenCheckerPlug
  action_fallback PetmeetWeb.FallbackController

  def index(conn, _params) do
    posts = Woofs.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Woofs.create_post(post_params, conn.assigns.pet) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Woofs.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Woofs.get_post!(id)

    with {:ok, %Post{} = post} <- Woofs.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Woofs.get_post!(id)
    with {:ok, %Post{}} <- Woofs.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
