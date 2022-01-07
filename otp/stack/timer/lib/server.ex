defmodule Timer.Server do
  use GenServer
  require Logger

  @min 1_000 * 60
  def start_link(_state) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(state) do
    Logger.info("Starting the timer")
    send_after()
    {:ok, state}
  end

  @impl true
  def handle_info(:tick, state) do
    {:ok, time} =
      Timex.local()
      |> Timex.format("%H:%M:%S", :strftime)

    Logger.info("Current time: #{time}")

    send_after()
    {:noreply, state}
  end

  defp send_after, do: Process.send_after(self(), :tick, @min)
end
