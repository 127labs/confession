defmodule Confession.PageController do
  use Confession, :controller

  def index(conn, _) do
    send_resp(conn, :ok, Confession.description)
  end
end
