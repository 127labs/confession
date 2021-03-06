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

      plug :put_secret_key_base

      def put_secret_key_base(conn, _) do
        Map.put(conn, :secret_key_base, Application.get_env(:confession, :secret_key_base))
      end

      def start_link do
        Logger.info "Starting server on http://0.0.0.0:4000"
        Plug.Adapters.Cowboy.http(__MODULE__, [])
      end
    end
  end

  def controller do
    quote do
      use Plug.Builder

      import Confession.ControllerHelpers

      def call(conn, opts) do
        action = Keyword.fetch!(opts, :action)

        conn =
          conn
          |> put_private(:action, action)
          |> super(opts)

        apply(__MODULE__, action, [conn, conn.params])
      end
    end
  end

  def context do
    quote do
      import Ecto.{Query, Changeset}, warn: false
    end
  end

  def view do
    quote do
      use Plug.Builder

      import Confession.ViewHelpers

      def call(conn, opts) do
        conn
        |> put_private(:view, __MODULE__)
        |> super(opts)
      end
    end
  end
end
