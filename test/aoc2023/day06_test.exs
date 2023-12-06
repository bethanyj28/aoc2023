defmodule Aoc2023.Day06Test do
  use ExUnit.Case
  import Aoc2023.Day06

  test "part1" do
    assert part1("./input/day06_test.txt") == 288
  end

  test "part2" do
    assert part2("./input/day06_test.txt") == 71503
  end
end
