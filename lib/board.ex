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

  def game_over(board_values, marker_one, marker_two, current_marker, turn, board_side_length\\ 3) do
    check_board_full(board_values, marker_one, marker_two) or check_for_victory(board_values, 3, current_marker) or max_turn(turn, board_side_length)
  end

  defp max_turn(turn, board_side_length) do
    turn > board_side_length * board_side_length
  end

  def check_board_full(board_values, player_one_marker, player_two_marker) do
    String.replace(board_values, player_one_marker, "") |> String.replace(player_two_marker, "") |> String.length() == 0
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

  def winner(board_values, player_one_name, marker_one, player_two_name, marker_two) do
    cond do
      check_for_victory(board_values, 3, marker_one) -> player_one_name
      check_for_victory(board_values, 3, marker_two) -> player_two_name
      true -> "Draw"
    end
  end
end