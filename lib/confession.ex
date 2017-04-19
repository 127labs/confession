defmodule Confession do
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  def description do
    """
    Confession is a bot for publishing post to a Facebook page anonymously,
    We don't store any data or references to your Facebook profile and you can find us on GitHub[0] to dig into our source code implementation.

    Our inspiration came from the likes of UniKL Confessions[1] and UITM Confessions[2] and the rest that follows a similar model.

    [0] https://github.com/imranismail/confession
    [1] https://www.facebook.com/uniklconfessions
    [2] https://www.facebook.com/uitm.confessions.official
    """
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
