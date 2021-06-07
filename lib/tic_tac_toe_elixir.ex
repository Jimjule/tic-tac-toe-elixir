defmodule TicTacToeElixir do
  def start(in_out\\ ConsoleInOut) do
    in_out.print Database.connect()
    game_history = Database.get_all_records()
    in_out.print "Number of games in history: #{length(game_history)}"

    in_out.print greet()
    in_out.print explain_rules()

    menu(in_out)
  end

  defp menu(in_out) do
    case in_out.read_input("Enter a number to choose:\n1. Play a game\n2. View game history\n3. Quit\n") |> String.replace("\n", "") do
      "1" -> set_up_game(in_out, is_player_two_human?(in_out))
      "2" -> game_history_menu(in_out)
      _default -> true
    end
  end

  defp set_up_game(in_out, human_player_two?) do
    player_one_name = "A"
    player_two_name = get_player_two_name(human_player_two?)
    game_loop(false, "123456789", "X", "A", "O", player_two_name, "X", 1, in_out, human_player_two?) |> Board.winner("X", player_one_name, "O", player_two_name) |> in_out.print
  end

  defp is_player_two_human?(in_out) do
    in_out.read_input("\nIs player two human? (Y/n)\n") |> String.replace("\n", "") |> String.match?(~r/y/i)
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
      true -> in_out.read_move()
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

  defp game_history_menu(in_out) do
    case in_out.read_input("\nEnter a number to choose:\n1. View list of games\n2. View a game by ID\n3. Search games by player name\n4. Return to main menu\n5. Quit\n") |> String.replace("\n", "") do
      "1" -> view_game_history(in_out)
      "2" -> view_specific_game(in_out)
      "3" -> search_games_by_player_name(in_out)
      "4" -> menu(in_out)
      _default -> true
    end
  end

  defp view_game_history(in_out) do
    format_game_loop(Database.get_all_records(), in_out)
    game_history_menu(in_out)
  end

  defp view_specific_game(in_out) do
    in_out.read_input("\n---Enter the ID of a game to view---\n") |> String.replace("\n", "") |> Database.get_record_by_id |> format_game_display(in_out)
    game_history_menu(in_out)
  end

  defp search_games_by_player_name(in_out) do
    in_out.read_input("\n---Enter the name of a player to search---\n") |> String.replace("\n", "") |> Database.get_records_by_player_name |> format_game_loop(in_out)
    game_history_menu(in_out)
  end

  def format_game_loop(records, in_out) do
    Enum.map(records, fn(record) -> format_game_history(record, in_out) end)
  end

  def format_game_history(record, in_out) do
    in_out.print "\n---Game Record---"
    "Game ID: #{record.id}" |> in_out.print
    "P1 Name: #{record.player_one_name}" |> in_out.print
    "P2 Name: #{record.player_two_name}" |> in_out.print
    "Date: #{record.updated_at}" |> in_out.print
  end

  defp format_game_display(record, in_out) do
    "---Game #{record.id}---" |> in_out.print
    "P1 Name: #{record.player_one_name}" |> in_out.print
    "P2 Name: #{record.player_two_name}" |> in_out.print
    "Date: #{record.updated_at}" |> in_out.print
    "Final Board:\n#{Board.split_board(record.board_state)}\n" |> in_out.print
  end

  defp greet do
    "\n===Welcome to TicTacToe - Elixir Edition!===\n"
  end

  defp explain_rules do
    "The first player to move is X. To make a move, type the number of an unmarked square.\nTo win, be the first to place three of your markers in a row horizontally, vertically, or diagonally.\n"
  end
end
