defmodule Problems do
  @moduledoc """
  Documentation for Problems.
  """

  @doc """
  ## Examples

      iex> Problems.fizz_buzz(20)
      [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11,
       "Fizz", 13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]

  """
  def fizz_buzz(max) do
    for i <- (1..max) do
      cond do
        rem(i, 15) == 0 ->
          "FizzBuzz"
        rem(i, 5) == 0 ->
          "Buzz"
        rem(i, 3) == 0 ->
          "Fizz"
        true ->
          i
      end
    end
  end


  @doc """
  ## Examples

      iex> Problems.sum([])
      0
      iex> Problems.sum([1, 2, 3, 4])
      10

  """
  def sum([]), do: 0
  def sum([el | rest]), do: el + sum(rest)

  @doc """
  ## Examples

      Problems.each [1, 2, 3], fn(el) -> el end
      :ok

  """
  def each([], _func), do: :ok
  def each([head | tail], func) do
    func.(head)
    Problems.each(tail, func)
  end

  @doc """
  ## Examples

      iex> Problems.map [1, 2, 3], fn(el) -> el * 2 end
      [2, 4, 6]

  """
  def map([], _func), do: []
  def map([head | tail], func) do
    [func.(head) | Problems.map(tail, func)]
  end


  @doc """
  ## Examples

      iex> Problems.fibonacci(0)
      []
      iex> Problems.fibonacci(1)
      [1]
      iex> Problems.fibonacci(2)
      [1, 1]
      iex> Problems.fibonacci(6)
      [1, 1, 2, 3, 5, 8]
  """
  @fib_seed [1, 1]
  def fibonacci(n) when n < 3, do: Enum.take(@fib_seed, n)
  def fibonacci(n) do
    last = fibonacci(n - 1)
    [x, y] = Enum.take(last, -2)
    last ++ [x + y]
  end
end
