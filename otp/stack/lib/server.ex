defmodule Stack.Server do
  use GenServer

  def push(val), do: GenServer.cast(__MODULE__, {:push, val})
  def pop, do: GenServer.call(__MODULE__, :pop)

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:push, val}, state) do
    {:noreply, [val | state]}
  end

  def handle_call(:pop, _from, []) do
    {:reply, [], []}
  end

  def handle_call(:pop, _from, [hd | tl]) do
    {:reply, hd, tl}
  end
end
