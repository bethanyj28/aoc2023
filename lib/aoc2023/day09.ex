defmodule Aoc2023.Day09 do
  def part1(filename) do
    Load.input(filename)
    |> Enum.map(fn line -> # split lines into lists of integers
      String.split(line)
      |> Enum.map(fn num_str -> String.to_integer(num_str) end)
    end)
    |> Enum.map(fn report -> 
      next = extrapolate(report)
      next + Enum.at(report, -1)
    end)
    |> Enum.sum()
  end

  def extrapolate(report) do
    if Enum.count(report, fn n -> n == 0 end) == length(report) do
      0
    else
      diffs = Enum.chunk_every(report, 2, 1, :discard)
      |> Enum.map(fn [a, b] -> 
        b-a
      end)
      Enum.at(diffs, -1) + extrapolate(diffs)
    end
  end

  def part2(filename) do
    Load.input(filename)
    |> Enum.map(fn line -> # split lines into lists of integers
      String.split(line)
      |> Enum.map(fn num_str -> String.to_integer(num_str) end)
    end)
    |> Enum.map(fn report -> 
      next = extrapolate_backwards(report)
      res = Enum.at(report, 0) - next
      res
    end)
    |> Enum.sum()
  end

  def extrapolate_backwards(report) do
    if Enum.count(report, fn n -> n == 0 end) == length(report) do
      0
    else
      diffs = Enum.chunk_every(report, 2, 1, :discard)
      |> Enum.map(fn [a, b] -> 
        b-a
      end)
      Enum.at(diffs, 0) - extrapolate_backwards(diffs)
    end
  end
end
