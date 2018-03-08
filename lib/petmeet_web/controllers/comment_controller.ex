defmodule PetmeetWeb.CommentController do
  use PetmeetWeb, :controller

  alias Petmeet.Meows
  alias Petmeet.Meows.Comment

  plug PetmeetWeb.Services.Plugs.TokenCheckerPlug

  action_fallback PetmeetWeb.FallbackController

  def index(conn, _params) do
    comments = Meows.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"post_id" => id, "comment" => comment_params}) do
    with {:ok, %Comment{} = comment} <- Meows.create_comment(comment_params, String.to_integer(id), conn.assigns.pet) do
      conn
      |> put_status(:created)
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Meows.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Meows.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Meows.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Meows.get_comment!(id)
    with {:ok, %Comment{}} <- Meows.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
