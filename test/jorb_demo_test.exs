defmodule JorbDemoTest do
  use ExUnit.Case
  doctest JorbDemo

  test "greets the world" do
    assert JorbDemo.hello() == :world
  end
end
