defmodule Aoc2023.Day08Test do
  use ExUnit.Case
  import Aoc2023.Day08

  test "part1" do
    assert part1("./input/day08_part1_test1.txt") == 2
    assert part1("./input/day08_part1_test2.txt") == 6
  end

  test "part2" do
    assert part2("./input/day08_part2_test.txt") == 6
  end
end
