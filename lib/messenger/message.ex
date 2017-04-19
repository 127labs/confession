defmodule Messenger.Message do
  defstruct recipient: nil,
            content: nil

  def new(opts \\ []) do
    struct(__MODULE__, opts)
  end

  def put_text(message, text) do
    Map.put(message, :content, %{text: text})
  end

  def put_recipient(message, recipient) do
    Map.put(message, :recipient, recipient)
  end

  def to_params(message) do
    %{
      recipient: %{
        id: message.recipient
      },
      message: message.content
    }
  end

  def from_text("/confess " <> confession) do
    put_text(new(), """
      Please confirm if this is your confession?:
        #{confession}
    """)
  end

  def from_text("/about") do
    put_text(new(), Confession.description)
  end

  def from_text("/about") do
    put_text(new(), """
      Available commands are:
        /help
        /about
        /confess <your-confession>
    """)
  end

  def from_text(_) do
    put_text(new(), """
      To get started, please type "/confess <your-confession>" or "/help" for help
    """)
  end
end
