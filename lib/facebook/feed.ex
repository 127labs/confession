defmodule Facebook.Feed do
  use Facebook

  def new do
    Conn.new()
    |> Conn.put_path("/v2.9/#{id()}/feed/")
    |> Conn.put_query_string(%{access_token: access_token()})
  end

  def new_post(conn, opts \\ []) do
    Conn.put_private(conn, :post, struct(Post, opts))
  end

  def publish!(conn, opts \\ []) do
    task = fn ->
      conn
      |> Conn.put_query_string(%{message: conn.private.post.message})
      |> post!()
    end

    case Keyword.get(opts, :async) do
      true ->
        Confession.Task.async(task)
      :nolink ->
        Confession.Task.async_nolink(task)
      _ ->
        task.()
    end
  end
end
