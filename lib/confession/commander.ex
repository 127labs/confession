defmodule Confession.Commander do
  require Logger

  alias Facebook.Message
  alias Confession.Feed
  # alias Facebook.Feed

  def confess(confession, sender) do
    case Feed.create_post(%{message: confession}) do
      {:ok, _post} ->
        Message.new()
        |> Message.put_text("Your confession has been published!")
        |> Message.put_recipient(sender)
        |> Message.send!(async: :nolink)
      {:error, changeset} ->
        Logger.error("Error creating post: #{inspect(changeset)}")

        Message.new()
        |> Message.put_text("Something went wrong, please try again.")
        |> Message.put_recipient(sender)
        |> Message.send!(async: :nolink)
    end

    # Facebook rejected this approach :(
    # Feed.new()
    # |> Feed.new_post(message: confession)
    # |> Feed.publish!(async: :nolink)

    # TODO(imranismail): Add confirmation step
    # Message.new()
    # |> Message.put_text("""
    #   Please confirm if this is your confession?:
    #     #{confession}
    # """)
    # |> Message.put_recipient(sender)
    # |> Message.send!(async: :nolink)
  end

  def about(sender) do
    Message.new()
    |> Message.put_text(Confession.description)
    |> Message.put_recipient(sender)
    |> Message.send!(async: :nolink)
  end

  def help(sender) do
    Message.new()
    |> Message.put_text("""
      Available commands are:
        /help
        /about
        /confess <your-confession>
    """)
    |> Message.put_recipient(sender)
    |> Message.send!(async: :nolink)
  end

  def default(sender) do
    Message.new()
    |> Message.put_text("""
      To get started, please type "/confess <your-confession>" or "/help" for help
    """)
    |> Message.put_recipient(sender)
    |> Message.send!(async: :nolink)
  end
end
