defmodule DiagonalVictoryTest do
  use ExUnit.Case
  doctest TicTacToeElixir

  test "check for diagonal victory" do
    assert Board.check_for_victory("XOO4X678X", 3, "X") == true
  end

  test "check rising diagonal victory" do
    assert Board.check_diagonal_victory("XOO4X678X", "X") == true
  end

  test "check no diagonal victory" do
    assert Board.check_diagonal_victory("O2O4X67X9", "X") == false
  end

  test "check falling diagonal victory" do
    assert Board.check_diagonal_victory("OOX4X6X89", "X") == true
  end

  test "check does not validate row or column victory" do
    assert Board.check_diagonal_victory("OXO4X67X9", "X") == false
    assert Board.check_diagonal_victory("XXXOO6789", "X") == false
  end
end
