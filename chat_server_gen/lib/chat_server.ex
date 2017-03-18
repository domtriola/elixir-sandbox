defmodule ChatServer do
  use GenServer
  alias ChatServer.Message

  # Client
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :chat_room)
  end

  def get do
    GenServer.call(:chat_room, {:get})
  end

  def create(content) do
    GenServer.cast(:chat_room, {:create, content})
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

# {:ok, pid} = ChatServer.start_link
# ChatServer.get() # => []
# ChatServer.create("hello world")
# ChatServer.get() # => [%ChatServer.Message{content: "hello world", username: "anon"}]


defmodule ChatServer.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :chat_supervisor)
  end

  def init(default) do
    children = [
      worker(ChatServer, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end

# ChatServer.Supervisor.start_link
# ChatServer.get() # => []
# ChatServer.create(, "hello world")
# ChatServer.get() # => [%ChatServer.Message{content: "chach", username: "anon"}]
