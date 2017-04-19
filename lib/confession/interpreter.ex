defmodule Confession.Interpreter do
  alias Confession.Commander

  def from_text(command, args \\ [])
  def from_text("/confess " <> confession, args), do: apply(Commander, :confess, [confession] ++ args)
  def from_text("/about", args), do: apply(Commander, :about, [] ++ args)
  def from_text("/help", args), do: apply(Commander, :help, [] ++ args)
  def from_text(_, args), do: apply(Commander, :default, [] ++ args)
end
