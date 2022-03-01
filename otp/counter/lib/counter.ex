defmodule Counter do
  alias Counter.Server
  defdelegate inc, to: Server
  defdelegate state, to: Server
  defdelegate clear, to: Server
end
