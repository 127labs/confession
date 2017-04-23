defmodule Confession.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Confession.Endpoint, []),
      supervisor(Confession.Task, []),
      supervisor(Confession.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Confession.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
