defmodule Messenger do
  use Maxwell.Builder

  middleware Maxwell.Middleware.BaseUrl, "https://graph.facebook.com/v2.6/me/messages"
  middleware Maxwell.Middleware.Opts, []
  middleware Maxwell.Middleware.Json,
    encode_content_type: MIME.type("json"),
    encode_func: &JSON.encode/1,
    decode_func: &JSON.decode/1
  middleware Maxwell.Middleware.Logger

  adapter Maxwell.Adapter.Hackney

  def send_message!(body, opts \\ []) do
    task = fn ->
      Maxwell.Conn.new()
      |> put_query_string(%{access_token: access_token()})
      |> put_req_body(body)
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

  def access_token do
    Application.fetch_env!(:confession, :fb_page_access_token)
  end

  def validation_token do
    Application.fetch_env!(:confession, :fb_messenger_validation_token)
  end

  defmacro __using__(_) do
    quote do
      import Maxwell.Conn, except: [new: 0]
      import Messenger
    end
  end
end
