defmodule Aoc2023.Day03 do
  def part1(filename) do
    input = [""] ++ Load.input(filename) # inserting fake first row
    sum_part_numbers(Enum.chunk_every(parse_rows(input), 3, 1, :discard))
  end

  def part2(filename) do
    input = [""] ++ Load.input(filename) # inserting fake first row
    sum_gear_ratios(Enum.chunk_every(parse_rows_for_gears(input), 3, 1, :discard))
  end

  def sum_part_numbers([]) do
    0
  end

  def sum_part_numbers([head | tail]) do
    sum_part_numbers(tail) + Enum.reduce(Enum.at(head, 1)[:nums], 0, fn x, acc -> 
      idx = x[:idx]
      num = x[:num]
      min = elem(idx, 0) - 1
      max = elem(idx, 0) + elem(idx, 1)

      symbols = head
      |> Enum.map(fn %{:symbols => symbols} -> symbols end)
      |> List.flatten()

      acc + Enum.reduce_while(symbols, 0, fn z, num_acc -> 
        if elem(z, 0) >= min && elem(z, 0) <= max do
          {:halt, num}
        else
          {:cont, num_acc}
        end
      end)
    end)
  end

  def sum_gear_ratios([]) do
    0
  end

  def sum_gear_ratios([head | tail]) do
    sum_gear_ratios(tail) + Enum.reduce(Enum.at(head, 1)[:symbols], 0, fn x, acc -> 
      idx = elem(x, 0)
      
      nums = head
      |> Enum.map(fn %{:nums => nums} -> nums end)
      |> List.flatten()
      
      gear = Enum.reduce_while(nums, {0, 1}, fn z, {count, gear_acc} -> 
        num_idx = z[:idx]
        num = z[:num]
        min = elem(num_idx, 0) - 1
        max = elem(num_idx, 0) + elem(num_idx, 1)
        if idx >= min && idx <= max do
          if count == 2 do
            {:halt, {count + 1, gear_acc * num}}
          else
            {:cont, {count + 1, gear_acc * num}}
          end
        else
          {:cont, {count, gear_acc}}
        end
      end)
      if elem(gear, 0) == 2 do
        acc + elem(gear, 1)
      else
        acc
      end
    
    end)
  end

  def parse_rows(schematic) do
    Enum.map(schematic, fn row -> 
      num_idxs = Enum.flat_map(
        Regex.scan(~r{(\d+)}, 
          row, 
          return: :index, 
          capture: :first), 
        fn x -> x 
      end)
      nums = Enum.flat_map(
        Regex.scan(
          ~r{(\d+)}, 
          row, 
          capture: :first
        ), 
        fn x -> 
          Enum.map(x, fn y -> String.to_integer(y) end) # convert string to int 
      end)
      symbols = Enum.flat_map(
        Regex.scan(~r{([^\.\d\n])}, 
          row, 
          return: :index, 
          capture: :first
        ), 
        fn x -> x 
      end)
      %{
        nums: Enum.zip_with(nums, num_idxs, fn x, y -> %{num: x, idx: y} end), 
        symbols: symbols
      }
    end)
  end

  def parse_rows_for_gears(schematic) do
    Enum.map(schematic, fn row -> 
      num_idxs = Enum.flat_map(
        Regex.scan(~r{(\d+)}, 
          row, 
          return: :index, 
          capture: :first), 
        fn x -> x 
      end)
      nums = Enum.flat_map(
        Regex.scan(
          ~r{(\d+)}, 
          row, 
          capture: :first
        ), 
        fn x -> 
          Enum.map(x, fn y -> String.to_integer(y) end) # convert string to int 
      end)
      symbols = Enum.flat_map(
        Regex.scan(~r{(\*)}, 
          row, 
          return: :index, 
          capture: :first
        ), 
        fn x -> x 
      end)
      %{
        nums: Enum.zip_with(nums, num_idxs, fn x, y -> %{num: x, idx: y} end), 
        symbols: symbols
      }
    end)
  end
end
