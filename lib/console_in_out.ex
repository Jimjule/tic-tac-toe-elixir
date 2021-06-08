defmodule ConsoleInOut do
  def print(output), do: IO.puts(output)

  def read_move, do: IO.gets "\nEnter a number to make your move: "

  def read_input(prompt), do: IO.gets prompt
end
