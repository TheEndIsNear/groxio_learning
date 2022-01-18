defmodule LinearTest do
  use ExUnit.Case
  doctest Linear

  test "greets the world" do
    assert Linear.hello() == :world
  end
end
