defmodule ChatServer do
  use GenServer
  alias ChatServer.Message

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :chat_room)
  end

  def get do
    GenServer.call(:chat_room, {:get})
  end

  def create(content) do
    GenServer.cast(:chat_room, {:create, content})
  end


  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:get}, _from, state) do
    {:reply, state, state}
  end
  def handle_call(request, from, state) do
    super(request, from, state)
  end

  def handle_cast({:create, content}, state) do
    {:noreply, state ++ [%Message{content: content}]}
  end
end
