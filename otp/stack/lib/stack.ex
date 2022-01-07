defmodule Stack do
  alias Stack.Server
  defdelegate push(val), to: Server
  defdelegate pop, to: Server
end
