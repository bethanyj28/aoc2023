defmodule Aoc2023.Day06 do
  def part1(filename) do
    Load.input(filename)
    |> Enum.map(fn line -> Regex.scan(~r{(\d+)}, line, capture: :all_but_first) end)
    |> Enum.map(fn line -> Enum.map(line, fn [n] -> String.to_integer(n) end) end)
    |> Enum.zip_with(fn [t, d] -> {t, -d} end)
    |> Enum.map(fn pair -> find_roots(pair) end)
    |> Enum.map(fn {x1, x2} -> next_int(x2, -1) - next_int(x1, 1) + 1 end)
    |> Enum.product()
  end

  def part2(filename) do
    Load.input(filename)
    |> Enum.map(fn line -> Regex.scan(~r{(\d+)}, String.replace(line, " ", ""), capture: :all_but_first) end)
    |> Enum.map(fn line -> Enum.map(line, fn [n] -> String.to_integer(n) end) end)
    |> Enum.zip_with(fn [t, d] -> {t, -d} end)
    |> Enum.map(fn pair -> find_roots(pair) end)
    |> Enum.map(fn {x1, x2} -> next_int(x2, -1) - next_int(x1, 1) + 1 end)
    |> Enum.product()
  end

  def find_roots({t, d}) do
    x1 = (-t + :math.sqrt((t*t) - (4*d*(-1)))) / -2
    x2 = (-t - :math.sqrt((t*t) - (4*d*(-1)))) / -2
    {x1, x2}
  end

  def next_int(n, dir) do
    cond do
      trunc(n) == n -> trunc(n) + dir
      dir == -1 -> trunc(n)
      true -> trunc(n) + dir
    end
  end
end
