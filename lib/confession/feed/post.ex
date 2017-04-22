defmodule Confession.Feed.Post do
  use Ecto.Schema

  schema "posts" do
    field :message

    timestamps()
  end
end
