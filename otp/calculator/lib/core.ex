defmodule Calculator.Core do
  def add(acc, number), do: acc + number
  def subtract(acc, number), do: acc - number
  def multiply(acc, number), do: acc * number
  def divide(acc, number), do: acc / number
  def inc(acc), do: acc + 1
  def dec(acc), do: acc - 1
  def negate(acc), do: -1 * acc

  def fold(list, acc, f) do
    Enum.reduce(list, acc, &f.(&2, &1))
  end
end
