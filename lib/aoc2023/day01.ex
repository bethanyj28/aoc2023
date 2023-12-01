defmodule Aoc2023.Day01 do
  def part1(filename) do
    calibrate(Load.input(filename))
  end 

  def part2(filename) do
    calibrate(Enum.map(Load.input(filename), fn code -> replace_string_nums(code) end))
  end

  def calibrate([_]) do
    0
  end

  def calibrate([head | tail]) do
    value = find_value(String.graphemes(head)) 
    calibrate(tail) + value
  end

  def find_value(code) do
    nums = Enum.flat_map(code, fn x ->
      case Integer.parse(x) do
        # transform to integer
        {int, _rest} -> [int]
        # skip the value
        :error -> []
      end
    end)

    num1 = Enum.at(nums, 0)
    num2 = Enum.at(nums, -1)
    (num1 * 10) + num2
  end

  def replace_string_nums(code) do
    # using these strings as replacements preserves any odd cases like eighthree as 83
    num_map = %{
      "one" => "one1one", 
      "two" => "two2two",
      "three" => "three3three",
      "four" => "four4four",
      "five" => "five5five",
      "six" => "six6six",
      "seven" => "seven7seven",
      "eight" => "eight8eight",
      "nine" => "nine9nine",
    }
    Enum.reduce(num_map, code, fn {k, v}, acc ->
      String.replace(acc, k, v)
    end)
  end
end
