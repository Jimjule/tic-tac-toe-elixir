defmodule BoardTest do
  use ExUnit.Case
  doctest TicTacToeElixir

  test "returns blank 3x3 board" do
    assert Board.print_board(nil) == "123\n456\n789"
  end

  test "returns populated 3x3 board" do
    assert Board.print_board("12X4O6X89") == "12X\n4O6\nX89"
  end
end
