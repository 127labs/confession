defmodule Confession.Mixfile do
  use Mix.Project

  def project do
    [
      app: :confession,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
     ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Confession.Application, []},
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.3"},
      {:jiffy, "~> 0.14"},
      {:cowboy, "~> 1.1"},
      {:decimal, "~> 1.0"},
      {:maxwell, github: "zhongwencool/maxwell"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 2.1"},
      {:hackney, ">= 0.0.0"},
    ]
  end
end
