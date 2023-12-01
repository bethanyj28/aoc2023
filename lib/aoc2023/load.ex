defmodule Load do
  def input(filename) do
    File.read!(filename)
    |> String.split("\n")
  end
end
