defmodule Confession.Task do
  def start_link do
    Task.Supervisor.start_link(name: __MODULE__, restart: :transient, max_restarts: 5)
  end

  def async_nolink(fun), do: Task.Supervisor.async_nolink(__MODULE__, fun)
  def async(fun), do: Task.Supervisor.async(__MODULE__, fun)
end
