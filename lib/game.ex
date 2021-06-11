defmodule Game do
  def game_loop(game_is_over?, board_values, player_one, player_two, current_player_marker, turn, in_out) do
    if game_is_over? do
      in_out.print Board.split_board(board_values)
      board_values
    else
      turn_logic(board_values, player_one, player_two, current_player_marker, turn, in_out)
    end
  end

  defp turn_logic(board_values, player_one, player_two, current_player_marker, turn, in_out) do
    in_out.print Board.split_board(board_values)
    updated_board = get_move_loop(board_values, in_out, player_one, player_two, current_player_marker, ~r/^[1-9]{1}$/)
      |> Board.make_move(board_values, current_player_marker)
    Board.game_over(updated_board, player_one.marker, player_two.marker, current_player_marker, turn)
      |> game_loop(updated_board, player_one, player_two, swap_player(player_one.marker, player_two.marker, current_player_marker), turn + 1, in_out)
  end

  defp get_move(board_values, in_out, player_one, player_two, current_player) do
    cond do
      current_player == player_two.marker and !player_two.human? -> handle_computer_player_turn(board_values, in_out, player_one.marker, player_two.marker)
      true -> "\nEnter a number to make your move: " |> in_out.read_input
    end
  end

  defp handle_computer_player_turn(board_values, in_out, marker_one, marker_two) do
    "\nComputer's move\n" |> in_out.print
    Board.calculate_first_empty_spot(board_values, marker_one, marker_two)
  end

  defp swap_player(marker_one, marker_two, current_player) do
    if current_player == marker_one do
      marker_two
    else
      marker_one
    end
  end

  defp get_move_loop(board_values, in_out, player_one, player_two, current_player_marker, validation) do
    move = get_move(board_values, in_out, player_one, player_two, current_player_marker)
    cond do
      String.match?(move, validation) -> move
      true -> get_move_loop(board_values, in_out, player_one, player_two, current_player_marker, validation)
    end
  end
end
