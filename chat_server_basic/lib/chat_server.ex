defmodule ChatServer do
  alias ChatServer.Message

  def loop do
    loop([])
  end
  def loop(state) do
    receive do
      {:create, msg} ->
        case msg do
          %{content: content, username: username} ->
            loop(state ++ [%Message{content: content, username: username}])
          msg ->
            loop(state ++ [%Message{content: msg}])
        end
      {:get, from} ->
        send(from, state)
        loop(state)
    end
  end
end
