defmodule Queue do
  use GenServer

  def handle_call(:dequeue, _from, [h | t]) do
    {:reply, h, t}
  end

  def handle_cast({:enqueue, item}, state) do
    {:noreply, state ++ [item]}
  end
end

{:ok, pid} = GenServer.start_link(Queue, [:first])

GenServer.cast(pid, {:enqueue, :second})
GenServer.call(pid, :dequeue) # => :first
GenServer.call(pid, :dequeue) # => :second

{:ok, _} = GenServer.start_link(Queue, [:another], name: AnotherQueue)
GenServer.call(AnotherQueue, :dequeue) # => :another


# Better public API
defmodule Queue do
  use GenServer

  # Client
  def start_link(default_state) do
    GenServer.start_link(__MODULE__, default_state)
  end

  def enqueue(pid, item) do
    GenServer.cast(pid, {:enqueue, item})
  end

  def dequeue(pid) do
    GenServer.call(pid, :dequeue)
  end

  # Server (callbacks)
  def handle_call(:dequeue, _from, [h | t]) do
    {:reply, h, t}
  end
  def handle_call(request, from, state) do
    super(request, from , state)
  end

  def handle_cast({:enqueue, item}, state) do
    {:noreply, state ++ [item]}
  end
  def handle_cast(request, state) do
    super(request, state)
  end
end

{:ok, pid} = Queue.start_link([:first])
Queue.enqueue(pid, :second)
Queue.dequeue(pid) # => :first
Queue.dequeue(pid) # => :second
