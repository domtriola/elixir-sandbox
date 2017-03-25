defmodule ChatWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    ChatServer.Supervisor.start_room("lobby")
    chat_list = ChatServer.get("lobby")
    {:ok, chat_list, socket}
  end
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    ChatServer.create("lobby", body)
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end
end
