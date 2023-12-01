defmodule Aoc2023.Day01Test do
  use ExUnit.Case
  import Aoc2023.Day01

  test "part1" do
    assert part1("./input/day01_part1_test.txt") == 142
  end

  test "part2" do
    assert part2("./input/day01_part2_test.txt") == 281
  end
end
