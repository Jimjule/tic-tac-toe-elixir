defmodule RowVictoryTest do
  use ExUnit.Case
  doctest TicTacToeElixir

  test "wins with a row" do
    assert Board.check_for_victory("XXXOO6789", 3, "X") == true
  end

  test "wins with second row" do
    assert Board.check_for_victory("OO3XXX789", 3, "X") == true
  end

  test "noughts can win with a row" do
    assert Board.check_for_victory("XX3OOO789", 3, "O") == true
  end

  test "does not win when no row" do
    assert Board.check_for_victory("XOXXOOOX9", 3, "X") == false
  end

  test "check row loop victory" do
    assert Board.check_row_loop("XXXOO6789", 3, 0, 0, "X") == true
  end

  test "column victory not detected by row checker" do
    assert Board.check_row_victory("OXO4X67X9", 3, 3, 0, "X") == false
  end
end
