## Processes ##
###############
# Processes are Elixir's unit of concurrency
# Processes have mailboxes

pid = spawn fn ->
  receive do
    {sender, :ping} ->
      IO.puts "Got ping"
      send sender, :pong
  end
end
Process.alive? pid # => true
send pid, {self(), :ping} # => Got ping
Process.alive? pid # => false

receive do
  message -> IO.puts "Got #{message} back"
end
# => Got pong back

receive do
  message -> IO.puts "This won't print"
after 1000 ->
  IO.puts "Timeout, no messages received"
end
# => Timeout, no messages received


defmodule Counter do
  def start(count \\ 0) do
    spawn fn -> listen(count) end
  end

  defp listen(count) do
    receive do
      :inc -> listen(count + 1)
      :dec -> listen(count - 1)
      {sender, :val} ->
        send sender, count
        listen(count)
    end
  end
end
pid = Counter.start
send(pid, :inc)
send(pid, :inc)
send(pid, :inc)
send(pid, :dec)
send(pid, {self(), :val})
receive do
  val -> val
end
# => 2

defmodule Counter.Client do
  def inc(pid), do: send(pid, :inc)
  def dec(pid), do: send(pid, :dec)
  def val(pid) do
    send pid, {self(), :val}
    receive do
      val -> val
    end
  end
end
Counter.Client.val(pid)
# => 2

## Registering Processes
pid = Counter.start 10
Process.register pid, :count
Process.whereis(:count) == pid # => true
Counter.Client.inc(:count)
Counter.Client.val(:count) # => 11
