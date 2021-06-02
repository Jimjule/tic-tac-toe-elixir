defmodule Database do
  def connect() do
    TicTacToeElixir.Repo.start_link()
    "\nDatabase: Started Link"
  end

  def getAllRecords() do
    TicTacToeElixir.Ttt_record |> TicTacToeElixir.Repo.all
  end
end

defmodule Board do
  def split_board(board_values) do
    Regex.scan(~r/.../, board_values) |> Enum.join("\n")
  end

  def make_move(move, board_values, marker) do
    String.replace(board_values, String.replace(move, "\n", ""), marker)
  end

  def calculate_first_empty_spot(board_values, marker_one, marker_two) do
    String.replace(board_values, marker_one, "") |> String.replace(marker_two, "") |> String.at(0)
  end

  def game_over(board_values, marker, turn, board_side_length\\ 3) do
    check_board_full(board_values) or check_for_victory(board_values, 3, marker) or max_turn(turn, board_side_length)
  end

  defp max_turn(turn, board_side_length) do
    turn > board_side_length * board_side_length
  end

  def check_board_full(board_values) do
    String.replace(board_values, "X", "") |> String.replace("O", "") |> String.length() == 0
  end

  def there_is_a_winner?(board_values, board_side_length, marker_one, marker_two) do
    check_for_victory(board_values, board_side_length, marker_one) or check_for_victory(board_values, board_side_length, marker_two)
  end

  def check_for_victory(board_values, board_side_length, marker) do
    check_diagonal_victory(board_values, marker) or check_row_loop(board_values, board_side_length, 0, 0, marker) or check_column_loop(board_values, board_side_length, 0, 0, marker)
  end

  def check_diagonal_victory(board_values, marker) do
    check_rising_diagonal(board_values, marker) or check_falling_diagonal(board_values, marker)
  end

  def check_rising_diagonal(board_values, marker) do
    String.at(board_values, 2) == marker and String.at(board_values, 4) == marker and String.at(board_values, 6) == marker
  end

  def check_falling_diagonal(board_values, marker) do
    String.at(board_values, 0) == marker and String.at(board_values, 4) == marker and String.at(board_values, 8) == marker
  end

  def check_row_loop(board_values, board_side_length, row_iterator, column_iterator, marker) do
    cond do
      is_checked?(board_side_length, row_iterator) -> false
      check_row_victory(board_values, board_side_length, row_iterator, column_iterator, marker) -> true
      true -> check_row_loop(board_values, board_side_length, row_iterator + 1, column_iterator, marker)
    end
  end

  def check_column_loop(board_values, board_side_length, row_iterator, column_iterator, marker) do
    cond do
      is_checked?(board_side_length, column_iterator) -> false
      check_column_victory(board_values, board_side_length, row_iterator, column_iterator, marker) -> true
      true -> check_row_loop(board_values, board_side_length, row_iterator + 1, column_iterator, marker)
    end
  end

  def is_checked?(board_side_length, iterator) do
    cond do
      board_side_length > iterator -> false
      true -> true
    end
  end

  def check_row_victory(board_values, board_side_length, row_iterator, column_iterator, marker) do
    cond do
      is_checked?(board_side_length, row_iterator) -> false
      true -> check_row(board_values, board_side_length, row_iterator, column_iterator, marker)
    end
  end

  def check_column_victory(board_values, board_side_length, row_iterator, column_iterator, marker) do
    cond do
      is_checked?(board_side_length, column_iterator) -> false
      true -> check_column(board_values, board_side_length, row_iterator, column_iterator, marker)
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

  def check_column(board_values, board_side_length, row_iterator, column_iterator, marker) do
    if String.at(board_values, board_side_length * row_iterator + column_iterator) == marker do
      case row_iterator == board_side_length - 1 do
        true -> true
        false -> check_column_victory(board_values, board_side_length, row_iterator + 1, column_iterator, marker)
      end
    else
      check_column_victory(board_values, board_side_length, 0, column_iterator + 1, marker)
    end
  end

  def winner(board_values, marker_one, player_one_name, marker_two, player_two_name) do
    cond do
      check_for_victory(board_values, 3, marker_one) -> player_one_name
      check_for_victory(board_values, 3, marker_two) -> player_two_name
      true -> "Draw"
    end
  end
end

defmodule ConsoleInOut do
  def print(output) do
    IO.puts(output)
  end

  def read do
    IO.gets "\nEnter a number to make your move: "
  end
end

defmodule TicTacToeElixir do
  def start(human_player_two?\\ false, in_out\\ ConsoleInOut) do
    in_out.print Database.connect()
    game_history = Database.getAllRecords()
    in_out.print "Number of games in history: "
    in_out.print length(game_history)
    in_out.print greet()
    in_out.print explain_rules()
    player_one_name = "A"
    player_two_name = get_player_two_name(human_player_two?)
    game_loop(false, "123456789", "X", player_one_name, "O", player_two_name, "X", 1, in_out, human_player_two?) |> Board.winner("X", player_one_name, "O", player_two_name) |> in_out.print
  end

  defp game_loop(game_is_over?, board_values, marker_one, player_one_name, marker_two, player_two_name, current_player, turn, in_out, human_player_two?) do
    if game_is_over? do
      in_out.print Board.split_board(board_values)
      board_values
    else
      turn_logic(board_values, marker_one, player_one_name, marker_two, player_two_name, current_player, turn, in_out, human_player_two?)
    end
  end

  defp get_player_two_name(human_player_two?) do
    if human_player_two? do
      "O"
    else
      "CPU"
    end
  end

  defp turn_logic(board_values, marker_one, player_one_name, marker_two, player_two_name, current_player, turn, in_out, human_player_two?) do
    in_out.print Board.split_board(board_values)
    updated_board = get_move(board_values, in_out, marker_one, marker_two, current_player, human_player_two?) |> Board.make_move(board_values, current_player)
    Board.game_over(updated_board, current_player, turn) |> game_loop(updated_board, marker_one, player_one_name, marker_two, player_two_name, swap_player(marker_one, marker_two, current_player), turn + 1, in_out, human_player_two?)
  end

  defp get_move(board_values, in_out, marker_one, marker_two, current_player, human_player_two) do
    cond do
      current_player == marker_two and human_player_two != true -> handle_computer_player_turn(board_values, in_out, marker_one, marker_two)
      true -> in_out.read()
    end
  end

  defp handle_computer_player_turn(board_values, in_out, marker_one, marker_two) do
    in_out.print "\nComputer's move\n"
    Board.calculate_first_empty_spot(board_values, marker_one, marker_two)
  end

  defp swap_player(marker_one, marker_two, current_player) do
    if current_player == marker_one do
      marker_two
    else
      marker_one
    end
  end

  defp greet do
    "\n===Welcome to TicTacToe - Elixir Edition!===\n"
  end

  defp explain_rules do
    "The first player to move is X. To make a move, type the number of an unmarked square.\nTo win, be the first to place three of your markers in a row horizontally, vertically, or diagonally.\n"
  end
end
