defmodule DetectVictorTest do
  use ExUnit.Case
  doctest TicTacToeElixir

  test "detects draw" do
    assert Board.there_is_a_winner?("XOXOXXOXO", 3, "X", "O") == false
  end

  test "detects no draw" do
    assert Board.there_is_a_winner?("XX3OOO789", 3, "X", "O") == true
  end

  test "detects player 1 victory" do
    assert Board.winner("OXO4X67X9", 3, "X", "O") == "X"
  end

  test "detects player 2 victory" do
    assert Board.winner("XX3OOO789", 3, "X", "O") == "O"
  end

  test "winner function detects draw" do
    assert Board.winner("XOXOXXOXO", 3, "X", "O") == "Draw"
  end
end
