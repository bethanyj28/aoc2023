defmodule Aoc2023.Day04 do
  def part1(filename) do
    count_scratch_card_points(Load.input(filename))
  end

  def count_scratch_card_points([_]), do: 0

  def count_scratch_card_points([head | tail]) do
    [winner_str] = Regex.run(~r{\:(.*)\|}, head, capture: :all_but_first)
    [values | _] = String.split(head, "|") |> Enum.reverse()
    total = Enum.reduce(String.split(values), 0, fn n, acc -> 
      if !String.contains?(winner_str, " #{n} ") do
        acc
      else
        if acc == 0 do
          1
        else
          acc * 2
        end
      end
    end)
    count_scratch_card_points(tail) + total
  end

  def part2(filename) do
    count_scratch_cards(Load.input(filename), %{})
  end

  def count_scratch_cards([_], counts), do: Enum.sum(Map.values(counts))

  def count_scratch_cards([head | tail], counts) do
    IO.puts(head)
    [game_id] = Regex.run(~r{Card[ ]*(\d+)}, head, capture: :all_but_first)  |> Enum.map(fn x -> String.to_integer(x) end)
    counts = Map.update(counts, game_id, 1, fn existing_value -> existing_value + 1 end) # count original card
    [winner_str] = Regex.run(~r{\:(.*)\|}, head, capture: :all_but_first)
    [values | _] = String.split(head, "|") |> Enum.reverse()
    total = Enum.reduce(String.split(values), 0, fn n, acc -> 
      if !String.contains?(winner_str, " #{n} ") do
        acc
      else
        acc + 1
      end
    end)
    if total > 0 do
      # use game id to find adder for new cards
      adder = Map.get(counts, game_id, 0)
      # loop through game_id..game_id + total and update counts with 1 + adder
      counts = Enum.reduce(game_id + 1..game_id + total, counts, fn n, acc -> 
        Map.update(acc, n, adder, fn existing_value -> existing_value + adder end)
      end)
      count_scratch_cards(tail, counts)
    else
      count_scratch_cards(tail, counts)
    end
  end
end
