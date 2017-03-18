## Pattern Matching ##
######################
[head | tail] = [1, 2, 3]
head # => 1
tail # => [2, 3]


## Keyword Lists ##
###################
alph = [a: "a", b: "b", c: "c"]
alph[:c] # => "c"
alph[:d] # => nil

Keyword.keys(alph) # => [:a, :b, :c]
Keyword.keys(alph) # => ["a", "b", "c"]

[{:tuple, "Tuple"}] == [tuple: "Tuple"]

if true, [do: "do end blocks are just keyword lists"]


## Functions are first class ##
###############################
add = fn x, y -> x + y end
multiply = fn x, y -> x * y end
calc = fn x, y, func ->
  func.(x, y)
end

calc.(2, 3, add) # => 5
calc.(2, 3, multiply) # => 6


## Function Shorthand/Capture ##
################################
Enum.map [1, 2, 3], &(&1 * 2)            # => [2, 4, 6]
Enum.map [1, 2, 3], fn el -> el * 2 end  # => [2, 4, 6]

Enum.reduce [1, 2, 3], 0, &Kernel.+/2 # => 6


## Modules ##
#############
defmodule Converter do
  alias :math, as: Math

  def degrees_to_radians(degrees) do
    degrees * (Math.pi / 180)
  end

  def sin_to_cos(x) do
    Math.cos(x - (Math.pi / 2))
  end
end
Converter.degrees_to_radians(90) # => 1.5707963267948966

defmodule Tau do
  def run do
    import :math
    pi * 2
  end
end
Tau.run # => 6.283185307179586

## Control Flow ##
##################
# if/else, no elsif
# cond
# case

zero = 0
calculate = fn expression ->
  case expression do
    {:+, x, y} -> x + y
    {:-, x, y} -> x - y
    {:*, x, 0} -> 0
    {:*, ^zero, y} -> 0
    {:*, x, y} -> x * y
    {:/, x, y} when y != 0 -> x / y
    _ -> raise "Unable to parse #{inspect expression}"
  end
end
