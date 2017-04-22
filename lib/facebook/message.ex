defmodule Facebook.Message do
  use Facebook

  defstruct recipient: nil,
            content: nil

  def new(opts \\ []) do
    Conn.new
    |> Conn.put_path("/v2.6/me/messages")
    |> Conn.put_query_string(%{access_token: access_token()})
    |> Conn.put_private(:message, struct(__MODULE__, opts))
  end

  def put_text(conn, text) do
    message =
      conn
      |> Conn.get_private(:message)
      |> Map.put(:content, %{text: text})

    Conn.put_private(conn, :message, message)
  end

  def put_recipient(conn, recipient) do
    message =
      conn
      |> Conn.get_private(:message)
      |> Map.put(:recipient, recipient)

    Conn.put_private(conn, :message, message)
  end

  def send!(conn, opts \\ []) do
    task = fn ->
      conn
      |> Conn.put_req_body(to_params(conn.private.message))
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

  def to_params(message) do
    %{
      recipient: %{
        id: message.recipient
      },
      message: message.content
    }
  end
end
