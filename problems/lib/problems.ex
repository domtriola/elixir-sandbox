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
end
