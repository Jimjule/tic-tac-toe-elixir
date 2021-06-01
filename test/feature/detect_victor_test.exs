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
    assert Board.winner("XXXOO6789", "X", "Y", "O", "U") == "Y"
  end

  test "declares O is the winner" do
    assert Board.winner("123XX6OOO", "X", "Y", "O", "U") == "U"
  end

  test "winner function detects draw" do
    assert Board.winner("XOXOXXOXO", "X", "X", "O", "O") == "Draw"
  end
end
