defmodule Aoc2023.Day03 do
  def part1(filename) do
    input = [""] ++ Load.input(filename) # inserting fake first row
    sum_part_numbers(Enum.chunk_every(parse_rows(input), 3, 1, :discard))
  end

  def part2(filename) do
    input = [""] ++ Load.input(filename) # inserting fake first row
    sum_gear_ratios(Enum.chunk_every(parse_rows(input), 3, 1, :discard))
  end

  def sum_part_numbers([]) do
    0
  end

  def sum_part_numbers([head | tail]) do
    sum_part_numbers(tail) + Enum.reduce(Enum.at(head, 1)[:nums], 0, fn num, acc -> 
      {min, max} = num[:range]
      val = num[:num]

      symbols = head
      |> Enum.map(fn %{:symbols => symbols} -> symbols end)
      |> List.flatten()

      acc + Enum.reduce_while(symbols, 0, fn sym, num_acc -> 
        {idx, _} = sym[:idx]
        if idx >= min && idx <= max do
          {:halt, val}
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
    sum_gear_ratios(tail) + Enum.reduce(Enum.at(head, 1)[:symbols], 0, fn sym, acc -> 
      val = sym[:symbol]
      if val != "*" do
        acc
      end

      {idx, _} = sym[:idx]
      
      nums = head
      |> Enum.map(fn %{:nums => nums} -> nums end)
      |> List.flatten()
      
    {gear_num_count, gear_prod} = Enum.reduce_while(nums, {0, 1}, fn num, {count, gear_acc} -> 
        {min, max} = num[:range]
        num_val = num[:num]
        if idx >= min && idx <= max do
          if count == 2 do # no need to continue, count is too high
            {:halt, {count + 1, gear_acc * num_val}}
          else
            {:cont, {count + 1, gear_acc * num_val}}
          end
        else
          {:cont, {count, gear_acc}}
        end
      end)
      if gear_num_count == 2 do
        acc + gear_prod
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
      symbols_idxs = Enum.flat_map(
        Regex.scan(~r{([^\.\d\n])}, 
          row, 
          return: :index, 
          capture: :first
        ), 
        fn x -> x 
      end)
      symbols = Enum.flat_map(
        Regex.scan(~r{([^\.\d\n])}, 
          row, 
          capture: :first
        ), 
        fn x -> x 
      end)
      %{
        nums: Enum.zip_with(nums, num_idxs, fn x, {idx, len} -> %{num: x, range: {idx - 1, idx + len}} end), 
        symbols: Enum.zip_with(symbols, symbols_idxs, fn x, y -> %{symbol: x, idx: y} end)
      }
    end)
  end
end
