defmodule Counter do
  alias Counter.Server
  defdelegate inc, to: Server
  defdelegate state, to: Server
end
