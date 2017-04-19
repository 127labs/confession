defmodule Confession.WebhookController do
  use Confession, :controller

  alias Messenger.Message
  alias Confession.Interpreter

  def show(conn, params) do
    params
    |> Map.get("hub.verify_token")
    |> Base.url_decode64!(padding: false)
    |> Kernel.==(Messenger.validation_token)
    |> case do
      true ->
        send_resp(conn, :ok, conn.params["hub.challenge"])
      false ->
        send_resp(conn, :bad_request, "Error, wrong validation token")
    end
  end

  def create(conn, params) do
    event = Messenger.Event.from_page(params)
    handle_event(event.topic, event)
    send_resp(conn, :ok, "")
  end

  defp handle_event("message", %{sender: sender, content: content}) do
    content
    |> Map.get("text")
    |> Interpreter.from_text([sender])
  end
end
