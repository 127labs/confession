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
end
