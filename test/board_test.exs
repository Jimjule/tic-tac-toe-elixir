defmodule BoardTest do
  use ExUnit.Case
  doctest TicTacToeElixir

  test "returns blank 3x3 board" do
    assert Board.print_board(nil) == "123\n456\n789"
  end

  test "returns populated 3x3 board" do
    assert Board.print_board("12X4O6X89") == "12X\n4O6\nX89"
  end

  test "returns board if not nil" do
    assert Board.get_board_string("12X4O6X89") == "12X4O6X89"
  end

  test "returns blank board if nil" do
    assert Board.get_board_string(nil) == "123456789"
  end

  test "board makes move if square available" do
    assert Board.make_move("123456789", "1", "X") == "X23456789"
  end

  test "board unchanged if square occupied" do
    assert Board.make_move("X23456789", "1", "O") == "X23456789"
  end
end
