defmodule EggTimer.Server do
  use GenServer
  alias EggTimer.Alarm

  def start_link(timers) when is_map(timers) do
    GenServer.start_link(__MODULE__, timers, name: __MODULE__)
  end

  @impl true
  def init(timers) do
    {:ok, timers}
  end

  def status do
    GenServer.call(__MODULE__, :status)
  end

  def stop do
    GenServer.cast(__MODULE__, :stop)
  end

  defp schedule(pid, %{name: name, duration: duration}) do
    Process.send_after(pid, {:alarm, name}, duration)
    :ok
  end

  @impl true
  def handle_cast({:schedule, name, duration, f}, timers) do
    alarm = Alarm.new(name, duration, f)
    schedule(self(), alarm)

    {:noreply, Map.put(timers, name, alarm)}
  end

  @impl true
  def handle_cast(:stop, timers) do
    {:stop, :normal, timers}
  end

  @impl true
  def handle_call(:status, _from, timers) do
    status = Enum.map(timers, fn {_name, alarm} -> Alarm.status(alarm) end)

    {:reply, status, timers}
  end

  @impl true
  def handle_info({:alarm, name}, timers) do
    Alarm.trigger(timers[name])
    new_timers = Map.delete(timers, name)

    {:noreply, new_timers}
  end
end
