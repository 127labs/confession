defmodule Confession.ControllerHelpers do
  alias Plug.Conn

  def put_view(conn, view) do
    Conn.put_private(conn, :view, view)
  end

  def render(conn, assigns) do
    type        = Conn.get_req_header(conn, "content-type")
    [extension] = MIME.extensions(type)
    action      = conn.private.action
    template    = Enum.join([action, extension], ".")
    content     = apply(conn.private.view, :render, [template, Enum.into(assigns, %{})])

    conn
    |> Conn.put_resp_content_type(type)
    |> Conn.send_resp(conn.status || :ok, content)
  end

  def render(conn, template, assigns) do
    type =
      ~r/.*\.(\w*)/
      |> Regex.run(template, capture: :all_but_first)
      |> Kernel.||("json")
      |> MIME.type()

    content = apply(conn.private.view, :render, [template, Enum.into(assigns, %{})])

    conn
    |> Conn.put_resp_content_type(type)
    |> Conn.send_resp(conn.status || :ok, content)
  end
end
