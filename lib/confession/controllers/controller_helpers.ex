defmodule Confession.ControllerHelpers do
  alias Plug.Conn

  @encoders %{
    "json" => &JSON.encode!/1
  }

  def put_view(conn, view) do
    Conn.put_private(conn, :view, view)
  end

  def render(conn, assigns) do
    type      = Conn.get_req_header(conn, "accept") |> List.first()
    extension = MIME.extensions(type) |> List.first() |> Kernel.||("json")
    type      = MIME.type(extension)
    action    = conn.private.action
    template  = Enum.join([action, extension], ".")
    encoder   = Map.get(@encoders, extension, fn any -> any end)
    content   =
      template
      |> conn.private.view.render(Enum.into(assigns, %{}))
      |> encoder.()

    conn
    |> Conn.put_resp_content_type(type)
    |> Conn.send_resp(conn.status || :ok, content)
  end

  def render(conn, template, assigns) do
    extension   =
      ~r/.*\.(\w*)/
      |> Regex.run(template, capture: :all_but_first)
      |> Kernel.||("json")
    encoder     = Map.get(@encoders, extension, fn any -> any end)
    type        = MIME.type(extension)
    content     =
      template
      |> conn.private.view.render(Enum.into(assigns, %{}))
      |> encoder.()

    conn
    |> Conn.put_resp_content_type(type)
    |> Conn.send_resp(conn.status || :ok, content)
  end
end
