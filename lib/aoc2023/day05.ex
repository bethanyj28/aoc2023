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
        {String.to_integer(start), String.to_integer(start) + String.to_integer(len)} 
      end) 
      |> Enum.map(fn x -> {x, false} end)

    map_seed_ranges_to_locations(tail, seed_starts)
  end

  def map_seed_ranges_to_locations([], seeds) do
    {{min_seed, _}, _} = Enum.min_by(seeds, fn {{seed_start, _seed_end}, _has_changed} -> seed_start end)
    min_seed
  end

  def map_seed_ranges_to_locations([head | tail], seeds) do
    if String.contains?(head, "map:") do
      seeds = Enum.map(seeds, fn {seed, _has_changed} -> 
        {seed, false}
      end)
      map_seed_ranges_to_locations(tail, seeds)
    else
      [dest_range_start, source_range_start, range_len] = Regex.scan(
        ~r{(\d+)}, 
        head, 
        capture: :all_but_first
      ) |> Enum.map(fn [range_data] -> String.to_integer(range_data) end)
      source_range_end = source_range_start + range_len - 1

      seeds = Enum.flat_map(seeds, fn {seed, has_changed} -> 
        {seed_start, seed_end} = seed
        cond do
          has_changed == true -> [{seed, has_changed}]
          seed_start == source_range_start and seed_end == source_range_end -> [{{dest_range_start, dest_range_start + range_len}, true}]
          seed_start >= source_range_start and seed_start <= source_range_start + range_len -> # rs----ss----re
            if seed_end <= source_range_end do # rs---[ss---se]---re
              [{{dest_range_start + (seed_start - source_range_start), dest_range_start + (seed_end - source_range_start)}, true}]
            else # rs---[ss---re][---se]
              [{{dest_range_start + (seed_start - source_range_start), dest_range_start + range_len}, true}, {{source_range_end + 1, seed_end}, false}]
            end
          seed_end >= source_range_start and seed_end <= source_range_start + range_len -> # [ss---rs][----se]----re
            [{{seed_start, source_range_start - 1}, false}, {{dest_range_start, dest_range_start + (seed_end - source_range_start)}, true}]
          true -> [{seed, has_changed}]
        end
      end)

      map_seed_ranges_to_locations(tail, seeds)
    end
  end
end
