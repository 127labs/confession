defmodule Confession.PostController do
  use Confession, :controller

  alias Confession.Feed

  plug Confession.PostView

  def index(conn, _) do
    posts = Feed.list_posts()
    render(conn, posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Feed.get_post!(id)
    render(conn, post: post)
  end
end
