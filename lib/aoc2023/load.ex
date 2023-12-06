defmodule Load do
  def input(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
  end
end
