defmodule Facebook.Event do
  defstruct recipient: nil,
            sender: nil,
            topic: nil,
            content: nil,
            timestamp: nil

  def from_page(%{"object" => "page", "entry" => entry}), do: from_entry(entry)
  def from_entry([%{"messaging" => event}]), do: from_event(event)
  def from_event([event]) do
    {splitted, event} = Map.split(event, ~w(recipient sender timestamp))
    [{topic, content}] = Map.to_list(event)

    %__MODULE__{
      topic: topic,
      recipient: get_in(splitted, ~w(recipient id)),
      sender: get_in(splitted, ~w(sender id)),
      timestamp: Map.get(splitted, "timestamp"),
      content: content
    }
  end
end
