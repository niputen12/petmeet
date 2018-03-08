defmodule PetmeetWeb.CommentView do
  use PetmeetWeb, :view
  alias PetmeetWeb.{CommentView, PetView}

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment1.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment1.json")}
  end

  def render("comment1.json", %{comment: comment}) do
    %{id: comment.id,
      body: comment.body
    }
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      body: comment.body,
       pet_who_commented: render_one(comment.pet, PetView, "pet.json")
    }
  end
end
