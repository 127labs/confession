defmodule Confession.PostView do
  use Confession, :view

  def render("show.json", %{post: post}) do
    %{
      data: render_one(post, __MODULE__, "post.json")
    }
  end

  def render("index.json", %{post: posts}) do
    %{
      data: render_many(posts, __MODULE__, "post.json")
    }
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      message: post.message
    }
  end
end
