defmodule TicTacToeElixir do
  def start(in_out\\ ConsoleInOut) do
    Logger.configure(level: :notice)
    in_out.print Database.connect()
    game_history = Database.get_all_records()
    in_out.print "Number of games in history: #{length(game_history)}"

    in_out.print greet()
    in_out.print explain_rules()

    menu(in_out)
  end

  defp menu(in_out) do
    case in_out.read_input("Enter a number to choose:\n1. Play a game\n2. View game history\n3. Quit\n") |> String.replace("\n", "") do
      "1" -> set_up_game(in_out)
      "2" -> game_history_menu(in_out)
      _default -> true
    end
  end

  defp set_up_game(in_out) do
    player_one_name = get_player_name(in_out, true, "1", "X")
    player_one_marker = get_player_marker(in_out, "X", true)
    player_one = %Player{name: player_one_name, marker: player_one_marker}
    human_player_two? = is_player_two_human?(in_out)
    player_two_name = get_player_name(in_out, human_player_two?, "2", "CPU")
    player_two_marker = get_player_marker(in_out, "O", human_player_two?)
    player_two = %Player{human?: human_player_two?, name: player_two_name, marker: player_two_marker}
    game_loop(false, "123456789", player_one, player_two, player_one.marker, 1, in_out) |> Board.winner(player_one, player_two) |> in_out.print
  end

  defp is_player_two_human?(in_out), do: in_out.read_input("\nIs player two human? (y/N)\n") |> String.replace("\n", "") |> String.match?(~r/y/i)

  defp game_loop(game_is_over?, board_values, player_one, player_two, current_player_marker, turn, in_out) do
    if game_is_over? do
      in_out.print Board.split_board(board_values)
      board_values
    else
      turn_logic(board_values, player_one, player_two, current_player_marker, turn, in_out)
    end
  end

  defp get_player_marker(in_out, default_marker, human?) do
    if human? do
      in_out.read_input("\nPlease enter your marker (1 letter): \n") |> String.replace("\n", "")
    else
      default_marker
    end
  end

  defp get_player_name(in_out, human?, which_player, default) do
    if human? do
      in_out.read_input("\nPlease enter player #{which_player} name (up to 3 letters):\n") |> String.replace("\n", "")
    else
      default
    end
  end

  defp turn_logic(board_values, player_one, player_two, current_player_marker, turn, in_out) do
    in_out.print Board.split_board(board_values)
    updated_board = get_move(board_values, in_out, player_one, player_two, current_player_marker) |> Board.make_move(board_values, current_player_marker)
    Board.game_over(updated_board, player_one.marker, player_two.marker, current_player_marker, turn) |> game_loop(updated_board, player_one, player_two, swap_player(player_one.marker, player_two.marker, current_player_marker), turn + 1, in_out)
  end

  defp get_move(board_values, in_out, player_one, player_two, current_player) do
    cond do
      current_player == player_two.marker and player_two.human? != true -> handle_computer_player_turn(board_values, in_out, player_one.marker, player_two.marker)
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

  def format_game_loop(records, in_out), do: Enum.map(records, fn(record) -> format_game_history(record, in_out) end)

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

  defp greet, do: "\n===Welcome to TicTacToe - Elixir Edition!===\n"

  defp explain_rules, do: "The first player to move is X. To make a move, type the number of an unmarked square.\nTo win, be the first to place three of your markers in a row horizontally, vertically, or diagonally.\n"
end
