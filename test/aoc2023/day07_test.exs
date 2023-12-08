defmodule Aoc2023.Day07Test do
  use ExUnit.Case
  import Aoc2023.Day07

  test "part1" do
    assert part1("./input/day07_test.txt") == 6440
  end

  test "part2" do
    assert part2("./input/day07_test.txt") == 5905
  end
end
