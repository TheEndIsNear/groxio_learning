defmodule Calculator do
  alias Calculator.Server

  defdelegate add(n), to: Server
  defdelegate subtract(n), to: Server
  defdelegate multiply(n), to: Server
  defdelegate divide(n), to: Server
  defdelegate clear, to: Server
  defdelegate negate, to: Server
  defdelegate state, to: Server
end
