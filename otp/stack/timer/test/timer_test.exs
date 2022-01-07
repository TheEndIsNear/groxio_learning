defmodule TimerTest do
  use ExUnit.Case
  doctest Timer

  test "greets the world" do
    assert Timer.hello() == :world
  end
end
