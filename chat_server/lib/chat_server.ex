defmodule ChatServer do
  def loop do
    receive do
      {:get, pid} -> send(pid, [])
    end
  end
end
