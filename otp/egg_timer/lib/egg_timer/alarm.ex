defmodule EggTimer.Alarm do
  alias EggTimer.Alarm
  defstruct ~w[duration name time f]a

  def new(name, duration, f \\ &default_fn/0)
      when is_atom(name) and is_integer(duration) and is_function(f) do
    __struct__(
      time: DateTime.utc_now(),
      name: name,
      duration: duration,
      f: f
    )
  end

  def trigger(%Alarm{f: f} = alarm) do
    f.()
    alarm
  end

  def status(%Alarm{name: name, duration: duration} = alarm) do
    {name, duration, remaining(alarm)}
  end

  def remaining(%Alarm{time: time, duration: duration}) do
    time
    |> DateTime.add(duration, :millisecond)
    |> DateTime.diff(DateTime.utc_now())
  end

  defp default_fn do
    IO.puts("Alarm triggered!")
  end
end
