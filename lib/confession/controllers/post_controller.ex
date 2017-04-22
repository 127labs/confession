defmodule Confession.PostController do
  use Confession, :controller

  alias Confession.Feed

  plug Confession.PostView

  def show(conn, %{"id" => id}) do
    post = Feed.get_post!(id)
    render(conn, post: post)
  end
end
