defmodule Board do
  def print_board(board_values) do
    Regex.scan(~r/.../, board_values) |> Enum.join("\n")
  end

  def make_move(current_board, move, marker) do
    String.replace(current_board, move, marker)
  end
end

defmodule ConsoleInOut do
  def print(output) do
    IO.puts(output)
  end

  def read do
    IO.gets "Enter a number to make your move: \n"
  end
end

defmodule TicTacToeElixir do
  def start(in_out) do
    in_out.print greet()
    in_out.print explain_rules()
    in_out.print Board.print_board("123456789")
  end

  defp greet do
    "\n===Welcome to TicTacToe - Elixir Edition!===\n"
  end

  defp explain_rules do
    "The first player to move is X. To make a move, type the number of an unmarked square.\nTo win, be the first to place three of your markers in a row horizontally, vertically, or diagonally.\n"
  end
end

TicTacToeElixir.start(ConsoleInOut)
