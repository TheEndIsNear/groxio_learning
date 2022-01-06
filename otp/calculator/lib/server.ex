defmodule Calculator.Server do
  use GenServer
  alias Calculator.Core

  def add(number), do: GenServer.cast(__MODULE__, {:add, number})
  def subtract(number), do: GenServer.cast(__MODULE__, {:subtract, number})
  def multiply(number), do: GenServer.cast(__MODULE__, {:multiply, number})
  def divide(number), do: GenServer.cast(__MODULE__, {:divide, number})
  def clear, do: GenServer.cast(__MODULE__, :clear)
  def state, do: GenServer.call(__MODULE__, :state)

  def start_link(initial) when is_integer(initial) do
    GenServer.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def init(number) do
    {:ok, number}
  end

  def handle_cast({:add, number}, state) do
    {:noreply, Core.add(state, number)}
  end

  def handle_cast({:subtract, number}, state) do
    {:noreply, Core.subtract(state, number)}
  end

  def handle_cast({:multiply, number}, state) do
    {:noreply, Core.multiply(state, number)}
  end

  def handle_cast({:divide, number}, state) do
    {:noreply, Core.divide(state, number)}
  end

  def handle_cast(:clear, _state) do
    {:noreply, 0}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end
end
