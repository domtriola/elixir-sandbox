defmodule Queue do
  use GenServer

  def start_link(state, opts \\ []) do
    GenServer.start_link(__MODULE__, state, opts)
  end

  def handle_call(:dequeue, _from, [h | t]) do
    {:reply, h, t}
  end

  def handle_cast({:enqueue, item}, state) do
    {:noreply, state ++ [item]}
  end
end

import Supervisor.Spec
children = [
  worker(Queue, [[:first], [name: MyQueue]])
]
{:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)
Supervisor.count_children(pid)
# => %{active: 1, specs: 1, supervisors: 0, workers: 1}

defmodule Queue.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(Queue, [[:first]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end

Queue.Supervisor.start_link
