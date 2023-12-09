defmodule Aoc2023.Day08 do
  def part1(filename) do
    [dir | map] = Load.input(filename)
    mapped = Map.new(map, fn str -> 
      [[src], [l], [r]] = Regex.scan(~r{([A-Z]+)}, str, capture: :all_but_first)
      {src, {l, r}}
    end)
    step(String.graphemes(dir), "AAA", "ZZZ", mapped, String.graphemes(dir), 0)
  end

  def step([], curr, goal, map, original_dirs, acc) do
    step(original_dirs, curr, goal, map, original_dirs, acc)
  end

  def step([dir | tail], curr, goal, map, original_dirs, acc) do
    if curr == goal do
      acc
    else
      {l, r} = Map.get(map, curr)
      new_curr = if dir == "R", do: r, else: l
      step(tail, new_curr, goal, map, original_dirs, acc + 1)
    end
  end

  def part2(filename) do
    [dir | map] = Load.input(filename)
    mapped = Map.new(map, fn str -> 
      [[src], [l], [r]] = Regex.scan(~r{([1-9A-Z]+)}, str, capture: :all_but_first)
      {src, {l, r}}
    end)

    starts = Map.keys(mapped) |> Enum.filter(fn str -> String.ends_with?(str, "A") end)

    Enum.map( # count to get to goal per start value
      starts, 
      fn start -> 
        ghost_step(
          String.graphemes(dir), 
          start, 
          "Z", 
          mapped, 
          String.graphemes(dir), 
          0
        ) 
    end) 
    |> Enum.reduce(1, fn n, acc -> # LCM
      gcd = MapSet.intersection(
        MapSet.new(find_prime_factors(n)), 
        MapSet.new(find_prime_factors(acc))
      ) 
        |> MapSet.to_list 
        |> Enum.max()
      acc * div(n, gcd)
    end)
  end

  def find_prime_factors(n) do
    find_prime_factors(n, 2, [1])
  end

  def find_prime_factors(n, i, acc) do
    if n == 1 do
      acc
    else
      if rem(n, i) == 0 do
        find_prime_factors(div(n, i), i, [i | acc])
      else
        find_prime_factors(n, i + 1, acc)
      end
    end
  end
  
  def ghost_step([], curr, goal, map, original_dirs, acc) do
    ghost_step(original_dirs, curr, goal, map, original_dirs, acc)
  end

  def ghost_step([dir | tail], curr, goal, map, original_dirs, acc) do # essentially the same as step/6 just with String.ends_with?/2
    if String.ends_with?(curr, goal) do
      acc
    else
      {l, r} = Map.get(map, curr)
      new_curr = if dir == "R", do: r, else: l
      ghost_step(tail, new_curr, goal, map, original_dirs, acc + 1)
    end
  end
end
