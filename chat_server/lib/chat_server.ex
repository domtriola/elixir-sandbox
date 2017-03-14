defmodule ChatServer do
  def loop do
    loop([])
  end
  def loop(state) do
    receive do
      {:create, msg} ->
        loop(state ++ [msg])
      {:get, from} ->
        send(from, state)
        loop(state)
    end
  end
end
