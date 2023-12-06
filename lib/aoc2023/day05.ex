defmodule Aoc2023.Day05 do
  def part1(filename) do
    [seeds | tail] = Load.input(filename)
    seed_starts = Regex.scan(~r{(\d+)}, seeds, capture: :all_but_first) |> Enum.map(fn [seed] -> {String.to_integer(seed), false} end)
    map_seeds_to_locations(tail, seed_starts)
  end

  def map_seeds_to_locations([], seeds) do
    {min_seed, _} = Enum.min(seeds)
    min_seed
  end

  def map_seeds_to_locations([head | tail], seeds) do
    if String.contains?(head, "map:") do
      seeds = Enum.map(seeds, fn {seed, _has_changed} -> 
        {seed, false}
      end)
      map_seeds_to_locations(tail, seeds)
    else
      [dest_range_start, source_range_start, range_len] = Regex.scan(
        ~r{(\d+)}, 
        head, 
        capture: :all_but_first
      ) |> Enum.map(fn [range_data] -> String.to_integer(range_data) end)

      seeds = Enum.map(seeds, fn {seed, has_changed} -> 
        cond do
          has_changed == true -> {seed, has_changed}
          seed >= source_range_start and seed <= source_range_start + range_len -> {dest_range_start + (seed - source_range_start), true}
          true -> {seed, has_changed}
        end
      end)

      map_seeds_to_locations(tail, seeds)
    end
  end
  
  def part2(filename) do
    [seeds | tail] = Load.input(filename)
    seed_starts = Regex.scan(
      ~r{(\d+)}, 
      seeds, 
      capture: :all_but_first
    ) 
      |> Enum.chunk_every(2, 2, :discard) 
      |> Enum.map(fn [[start], [len]] -> 
        {String.to_integer(start), String.to_integer(len)} 
      end) 
      |> Enum.flat_map(fn {x, y} -> x..(x+y) end)
      |> Enum.map(fn x -> {x, false} end)
    map_seeds_to_locations(tail, seed_starts)
  end
end
