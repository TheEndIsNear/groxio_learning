defmodule Counter.Server do
  use GenServer

  def inc, do: GenServer.cast(__MODULE__, :inc)
  def state, do: GenServer.call(__MODULE__, :state)
  def clear, do: GenServer.cast(__MODULE__, :clear)

  def start_link(state \\ 0) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast(:inc, state) do
    {:noreply, state + 1}
  end

  def handle_cast(:clear, _state) do
    {:noreply, 0}
  end

  @impl true
  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end
end
