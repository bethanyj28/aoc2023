defmodule Aoc2023.Day03Test do
  use ExUnit.Case
  import Aoc2023.Day03

  test "part1" do
    assert part1("./input/day03_test.txt") == 4361
  end

  test "part2" do
    assert part2("./input/day03_test.txt") == 467835
  end
end
