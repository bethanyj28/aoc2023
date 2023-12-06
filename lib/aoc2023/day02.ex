defmodule Aoc2023.Day02 do
  def part1(filename) do
    input = Load.input(filename)
    sum_games(input)
  end

  def part2(filename) do
    input = Load.input(filename)
    sum_powers(input)
  end

  def sum_games([]) do
    0
  end

  def sum_games([head | tail]) do
    id = id_value(head)
    sum_games(tail) + id
  end

  def sum_powers([]) do
    0
  end

  def sum_powers([head | tail]) do
    power = power_value(head)
    sum_powers(tail) + power
  end

  def power_value(game_str) do
    colors = ["red", "blue", "green"]
    Enum.reduce(colors, 1, fn color, acc ->
      max_for_color(color, game_str) * acc
    end)
  end

  def id_value(game_str) do
    color_maxes = %{
      "red" => 12,
      "blue" => 14,
      "green" => 13,
    }
    impossible = Enum.reduce_while(color_maxes, 0, fn {k, v}, acc ->
      if max_for_color(k, game_str) > v do # impossible
        # set acc to id from game_str
        {:halt, 1}
      else
        {:cont, acc}
      end
    end)
    if impossible == 0 do
      captures = Regex.named_captures(~r{Game (?<id>.*?):}, game_str)
      String.to_integer(captures["id"])
    else
      0
    end
  end

  def max_for_color(color, game_str) do
    # use regex to find values and choose max
    matches = Regex.scan(~r{(\d+) #{color}}, game_str, capture: :all_but_first)
    Enum.max(Enum.map(matches, &String.to_integer(List.first(&1, 0))), fn -> 0 end)
  end
end
