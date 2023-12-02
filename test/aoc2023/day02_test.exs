defmodule Aoc2023.Day02Test do
  use ExUnit.Case
  import Aoc2023.Day02

  test "part1" do
    assert part1("./input/day02_test.txt") == 8
  end

  test "part2" do
    assert part2("./input/day02_test.txt") == 2286
  end
end
