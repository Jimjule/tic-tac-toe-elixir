defmodule DetectVictorTest do
  use ExUnit.Case
  doctest Board

  test "detects draw" do
    assert Board.there_is_a_winner?("XOXOXXOXO", 3, "X", "O") == false
  end

  test "detects no draw" do
    assert Board.there_is_a_winner?("XX3OOO789", 3, "X", "O") == true
  end

  test "declares X is the winner" do
    player_one = %Player{name: "X", marker: "X"}
    player_two = %Player{name: "CPU", marker: "O"}
    assert Board.winner("XXXOO6789", player_one, player_two) == "X"
  end

  test "declares O is the winner" do
    player_one = %Player{name: "X", marker: "X"}
    player_two = %Player{name: "CPU", marker: "Y"}
    assert Board.winner("123XX6YYY", player_one, player_two) == "CPU"
  end

  test "winner function detects draw" do
    player_one = %Player{name: "X", marker: "X"}
    player_two = %Player{name: "CPU", marker: "O"}
    assert Board.winner("XOXOXXOXO", player_one, player_two) == "Draw"
  end
end
