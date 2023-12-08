defmodule Aoc2023.Day07 do
  def part1(filename) do
    {total, _} = Load.input(filename)
    |> Enum.map(fn line -> 
        [hand, bid] = String.split(line)
        {hand, String.to_integer(bid)}
    end)
    |> Enum.sort(fn {hand1, _bid1}, {hand2, _bid2} -> 
      compare_hands(hand2, hand1, String.graphemes("23456789TJQKA"), false)
    end)
    |> Enum.reduce({0, 1}, fn {_hand, bid}, {acc, i} -> {acc + bid * i, i + 1} end)
    total
  end

  def part2(filename) do
    {total, _} = Load.input(filename)
    |> Enum.map(fn line -> 
        [hand, bid] = String.split(line)
        {hand, String.to_integer(bid)}
    end)
    |> Enum.sort(fn {hand1, _bid1}, {hand2, _bid2} -> 
      compare_hands(hand2, hand1, String.graphemes("J23456789TQKA"), true)
    end)
    |> Enum.reduce({0, 1}, fn {_hand, bid}, {acc, i} -> {acc + bid * i, i + 1} end)
    total
  end

  def compare_hands(hand1, hand2, card_rank, wildcard) do
    type1 = if wildcard, do: get_type_wildcards(hand1), else: get_type(hand1)
    type2 = if wildcard, do: get_type_wildcards(hand2), else: get_type(hand2)
    cond do
      type1 > type2 -> true
      type1 < type2 -> false
      true -> Enum.reduce_while(Stream.zip(String.graphemes(hand1), String.graphemes(hand2)), true, fn {card1, card2}, acc ->
        cond do
          card1 == card2 -> {:cont, acc}
          card_rank |> Enum.find_index(&(&1 == card1)) > card_rank |> Enum.find_index(&(&1 == card2)) -> {:halt, true}
          true -> {:halt, false}
        end
      end)
    end
  end

  def get_type(hand) do
    [first | tail] = Enum.frequencies(String.graphemes(hand)) |> Map.values() |> Enum.sort(:desc)
    second = Enum.at(tail, 0) || 0
    cond do
      first == 5 -> 7 #five_of_a_kind
      first == 4 -> 6 #four_of_a_kind
      first == 3 and second == 2 -> 5 #full_house
      first == 3 -> 4 #three_of_a_kind
      first == 2 and second == 2 -> 3 #two_pairs
      first == 2 -> 2 #one_pair
      true -> 1 #high_card
    end
  end

  def get_type_wildcards(hand) do
    freq = Enum.frequencies(String.graphemes(hand)) 
    {jokers, freq} = Map.pop(freq, "J", 0)
    vals = Map.values(freq) |> Enum.sort(:desc)
    first = Enum.at(vals, 0) || 0
    second = Enum.at(vals, 1) || 0
    cond do
      first + jokers == 5 -> 7 #five_of_a_kind
      first + jokers == 4 -> 6 #four_of_a_kind
      first + jokers == 3 and second == 2 -> 5 #full_house
      first == 3 and second + jokers == 2 -> 5 #full_house
      first + jokers == 3 -> 4 #three_of_a_kind
      first + jokers == 2 and second == 2 -> 3 #two_pairs
      first == 2 and second + jokers == 2 -> 3 #two_pairs
      first + jokers == 2 -> 2 #one_pair
      true -> 1 #high_card
    end
  end
end
