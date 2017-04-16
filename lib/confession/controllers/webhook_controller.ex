defmodule Confession.WebhookController do
  use Confession, :controller

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

  def create(conn, %{"object" => "page"} = params) do
    params
    |> compose_message()
    |> Messenger.send_message!(async: :nolink)

    send_resp(conn, :ok, "")
  end

  def create(conn, _) do
    send_resp(conn, :bad_request, "")
  end

  defp sender(%{"entry" => [%{"messaging" => [%{"sender" => sender}]}]}), do: sender
  defp text(text), do: %{text: text}
  defp compose_message(params) do
    %{recipient: sender(params), message: text("Hello, world!")}
  end
end
