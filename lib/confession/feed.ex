defmodule Confession.Feed do
  use Confession, :context

  alias Confession.{
    Repo,
    Feed.Post,
  }

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> post_changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> post_changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    post_changeset(post, %{})
  end

  defp post_changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
