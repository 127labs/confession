defmodule Confession.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Confession.Endpoint.spec(),
      supervisor(Confession.Task, []),
    ]

    opts = [strategy: :one_for_one, name: Confession.Supervisor]

    Supervisor.start_link(children, opts)
  end
end