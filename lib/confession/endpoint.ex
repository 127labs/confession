defmodule Confession.Endpoint do
  use Confession, :endpoint

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, JSON.Parser],
    pass: ["*/*"],
    json_decoder: JSON

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_confession_key",
    signing_salt: "7qBQTogB"

  plug Confession.Router
end
