defmodule PetmeetWeb.PostView do
  use PetmeetWeb, :view
  alias PetmeetWeb.{PostView, CommentView, PetView}

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      pet_who_posted: render_one(post.pet, PetView, "pet.json"),
      body: post.body,
      comments: render_many(post.comments, CommentView, "comment.json")
    }
  end

  def render("own_post.json", %{post: post}) do
    %{id: post.id,
      body: post.body,
      comments: render_many(post.comments, CommentView, "comment.json")
    }
  end
end
