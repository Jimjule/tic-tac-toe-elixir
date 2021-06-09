defmodule ConsoleInOut do
  def print(output), do: IO.puts(output)

  def read_input(prompt), do: prompt |> IO.gets |> String.replace("\n", "")
end
