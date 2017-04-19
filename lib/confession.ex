defmodule Confession do
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  def router do
    quote do
      use Plug.Router

      if Mix.env == :dev do
        use Plug.Debugger
      end

      use Plug.ErrorHandler

      plug :match
      plug :dispatch

      defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
        send_resp(conn, conn.status, "Something went wrong")
      end
    end
  end

  def endpoint do
    quote do
      use Plug.Builder

      require Logger

      def spec do
        proto = :http
        ip    = {127, 0, 0, 1}
        port  = 4000

        Logger.info "Starting server on " <> "#{proto}://#{:inet_parse.ntoa(ip)}:#{port}"

        Plug.Adapters.Cowboy.child_spec(proto, __MODULE__, [], [port: port, ip: ip])
      end
    end
  end

  def controller do
    quote do
      use Plug.Builder

      def call(conn, opts) do
        apply(__MODULE__, Keyword.fetch!(opts, :action), [conn, conn.params])
      end
    end
  end
end
