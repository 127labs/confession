defmodule Confession.Router do
  use Confession, :router

  get "/webhook", to: Confession.WebhookController, init_opts: [action: :show]
  post "/webhook", to: Confession.WebhookController, init_opts: [action: :create]

  match _, do: send_resp(conn, 404, "Nothing to see here")
end
