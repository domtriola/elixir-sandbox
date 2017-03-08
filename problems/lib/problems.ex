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
      case {15, 5, 3} do
        {x, 5, 3} when rem(i, x) == 0 ->
          "FizzBuzz"
        {15, x, 3} when rem(i, x) == 0 ->
          "Buzz"
        {15, 5, x} when rem(i, x) == 0 ->
          "Fizz"
        _ ->
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
  def sum([]) do
    0
  end
  def sum([el | rest]) do
    el + sum(rest)
  end
end
