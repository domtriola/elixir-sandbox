defmodule ChatServer do
  use GenServer

  defmodule Message do
    defstruct content: nil, username: "anon"
  end

  # Client
  def start_link(room_name) do
    GenServer.start_link(__MODULE__, :ok, name: via_tuple(room_name))
  end

  def get(room_name) do
    GenServer.call(via_tuple(room_name), {:get})
  end

  def create(room_name, content) do
    GenServer.cast(via_tuple(room_name), {:create, content})
  end

  defp via_tuple(room_name) do
    {:via, Registry, {:chat_room, room_name}}
  end


  # Server
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
  def handle_cast(request, state) do
    super(request, state)
  end
end

defmodule ChatServer.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: :chat_supervisor)
  end

  def start_room(name) do
    Supervisor.start_child(:chat_supervisor, [name])
  end

  def init(:ok) do
    Registry.start_link(:unique, :chat_room)

    children = [
      worker(ChatServer, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end

# ChatServer.Supervisor.start_link
# ChatServer.Supervisor.start_room "foo"
# ChatServer.Supervisor.start_room "bar"
# ChatServer.create "foo", "foobar"
# ChatServer.get("foo") # => [%ChatServer.Message{content: "foobar", username: "anon"}]
# ChatServer.get("bar") # => []
