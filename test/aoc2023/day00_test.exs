defmodule Aoc2023.Day0Test do
  use ExUnit.Case
  import Aoc2023.Day0

  test "part1" do
    input = 20  
    assert ExUnit.CaptureIO.capture_io(fn -> part1(input) end) == "hello, world: 20\n"
  end

  test "part2" do
    input = 20  
    assert ExUnit.CaptureIO.capture_io(fn -> part2(input) end) == "hello, world: 20\n"
  end
end
