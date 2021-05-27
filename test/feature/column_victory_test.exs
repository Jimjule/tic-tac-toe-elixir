defmodule ColumnVictoryTest do
  use ExUnit.Case
  doctest TicTacToeElixir

  test "check for victory with a column" do
    assert Board.check_for_victory("XOOX56X89", 3, "X") == true
  end

  test "check column victory" do
    assert Board.check_column_loop("XOOX56X89", 3, 0, 0, "X") == true
  end

  test "check column no victory" do
    assert Board.check_column_loop("O2O4X67X9", 3, 0, 0, "X") == false
  end

  test "check second column victory" do
    assert Board.check_column_loop("OXO4X67X9", 3, 0, 0, "X") == true
  end

  test "check does not validate row victory" do
    assert Board.check_column_loop("XXXOO6789", 3, 0, 0, "X") == false
  end
end
