defmodule Aoc2023.Day05Test do
  use ExUnit.Case
  import Aoc2023.Day05

  test "part1" do
    assert part1("./input/day05_test.txt") == 35
  end

  test "part2" do
    assert part2("./input/day05_test.txt") == 46
  end
end
