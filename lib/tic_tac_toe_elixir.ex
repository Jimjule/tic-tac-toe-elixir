defmodule Board do
  def print_board(board_values) do
    board_string = get_board_string(board_values)
    list = List.flatten(Regex.scan(~r/.../, board_string))
    Enum.join(list, "\n")
  end

  def get_board_string(board_values) do
    if board_values == nil do
      "123456789"
    else
      board_values
    end
  end
end

defmodule ConsoleInOut do
  def print(output) do
    IO.puts(output)
  end
end

defmodule TicTacToeElixir do
  def start(in_out) do
    in_out.print greet()
    in_out.print explain_rules()
    in_out.print Board.print_board(nil)
  end

  def greet do
    "Welcome to TicTacToe - Elixir Edition!"
  end

  def explain_rules do
    "The first player to move is X. To make a move, type the number of an unmarked square. To win, be the first to place three of your markers in a row horizontally, vertically, or diagonally.\n"
  end
end

TicTacToeElixir.start(ConsoleInOut)
