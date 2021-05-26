defmodule Board do
  def split_board(board_values) do
    Regex.scan(~r/.../, board_values) |> Enum.join("\n")
  end

  def make_move(current_board, move, marker) do
    String.replace(current_board, move, marker)
  end

  def game_over(board_values, marker) do
    check_board_full(board_values) || check_for_victory(board_values, 3, marker)
  end

  def check_board_full(board_values) do
    String.replace(board_values, "X", "") |> String.replace("O", "") |> String.length() == 0
  end

  def check_for_victory(board_values, board_side_length, marker) do
    check_row_loop(board_values, board_side_length, 0, 0, marker)
  end

  def check_row_loop(board_values, board_side_length, row_iterator, column_iterator, marker) do
    cond do
      is_checked?(board_side_length, row_iterator) -> false
      check_row_victory(board_values, board_side_length, row_iterator, column_iterator, marker) -> true
      true -> check_row_loop(board_values, board_side_length, row_iterator + 1, column_iterator, marker)
    end
  end

  def is_checked?(board_side_length, iterator) do
    cond do
      board_side_length > iterator -> false
      true -> true
    end
  end

  def check_row(board_values, board_side_length, row_iterator, column_iterator, marker) do
    if String.at(board_values, board_side_length * row_iterator + column_iterator) == marker do
      case column_iterator == board_side_length - 1 do
        true -> true
        false -> check_row_victory(board_values, board_side_length, row_iterator, column_iterator + 1, marker)
      end
    else
      check_row_victory(board_values, board_side_length, row_iterator + 1, 0, marker)
    end
  end

  def check_row_victory(board_values, board_side_length, row_iterator, column_iterator, marker) do
    cond do
      is_checked?(board_side_length, row_iterator) -> false
      true -> check_row(board_values, board_side_length, row_iterator, column_iterator, marker)
    end
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
    in_out.print Board.split_board("123456789")
  end

  defp game_loop(game_is_over?, board_values) do

    game_loop(Board.game_over(board_values), board_values)
  end

  defp greet do
    "\n===Welcome to TicTacToe - Elixir Edition!===\n"
  end

  defp explain_rules do
    "The first player to move is X. To make a move, type the number of an unmarked square.\nTo win, be the first to place three of your markers in a row horizontally, vertically, or diagonally.\n"
  end
end

TicTacToeElixir.start(ConsoleInOut)
