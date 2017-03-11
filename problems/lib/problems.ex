defmodule Problems do
  @moduledoc """
  Documentation for Problems.
  """

  @doc """
  ## Examples

      iex> Problems.range(0, 10)
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  """
  def range(x, y) when x > y, do: []
  def range(x, y) when x == y, do: [x]
  def range(x, y) do
    [x] ++ range(x + 1, y)
  end

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

      iex> Problems.reduce [1, 2, 3], fn(accum, el) -> accum + el end
      6
      iex> Problems.reduce [1, 2, 3, 4], fn(accum, el) -> accum * el end
      24

  """
  def reduce([el], _func), do: el
  def reduce([head | tail], func) do
    func.(head, Problems.reduce(tail, func))
  end

  @doc """
  ## Examples

      iex> Problems.reduce [1, 2, 3], 4, fn(accum, el) -> accum + el end
      10

  """
  def reduce([], seed, _func), do: seed
  def reduce([head | tail], seed, func) do
    func.(seed, Problems.reduce(tail, head, func))
  end


  @doc """
  ## Examples

      iex> Problems.select [1, 2, 3, 4], fn(el) -> rem(el, 2) == 0 end
      [2, 4]

  """
  def select([], _func), do: []
  def select([head | tail], func) do
    case func.(head) do
      true ->
        [head | Problems.select(tail, func)]
      _else ->
        Problems.select(tail, func)
    end
  end


  @doc """
  ## Examples

      iex> Problems.any [1, 2, 3], fn(el) -> rem(el, 2) == 0 end
      true
      iex> Problems.any [1, 3, 5, 7], fn(el) -> rem(el, 2) == 0 end
      false

  """
  def any([], _func), do: false
  def any([head | tail], func) do
    case func.(head) do
      true ->
        true
      _else ->
        Problems.any(tail, func)
    end
  end


  @doc """
  ## Examples

      iex> Problems.rotate([1, 2, 3])
      [2, 3, 1]
      iex> Problems.rotate([1, 2, 3, 4], 2)
      [3, 4, 1, 2]

  """
  def rotate(list, shift \\ 1)
  def rotate([], _shift), do: []
  def rotate([head | tail], shift) do
    cond do
      shift > 0 ->
        rotate(tail ++ [head], shift - 1)
      true ->
        [head | tail]
    end
  end


  @doc """
  ## Examples

      iex> Problems.uniq([1, 2, 2, 4, 4])
      [1, 2, 4]

  """
  def uniq(list) do
    MapSet.new(list)
    |> MapSet.to_list
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
