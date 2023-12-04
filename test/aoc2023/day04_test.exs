defmodule Aoc2023.Day04Test do
  use ExUnit.Case
  import Aoc2023.Day04

  test "part1" do
    assert part1("./input/day04_test.txt") == 13
  end

  test "part2" do
    assert part2("./input/day04_test.txt") == 30
  end
end
