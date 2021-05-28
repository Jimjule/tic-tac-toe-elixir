defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "returns blank 3x3 board" do
    assert Board.split_board("123456789") == "123\n456\n789"
  end

  test "returns populated 3x3 board" do
    assert Board.split_board("12X4O6X89") == "12X\n4O6\nX89"
  end

  test "board makes move if square available" do
    assert Board.make_move("123456789", "1", "X") == "X23456789"
  end

  test "board unchanged if square occupied" do
    assert Board.make_move("X23456789", "1", "O") == "X23456789"
  end

  test "board marks a second square" do
    assert Board.make_move("X234O6789", "5", "O") == "X234O6789"
  end

  test "game is over when board is full without a victory" do
    assert Board.game_over("XOXXOOOXX", "X", 1) == true
  end

  test "game is over when turn count is max" do
    assert Board.game_over("XOXXOOOX9", "X", 10) == true
  end

  test "game is not over when board is not full" do
    assert Board.game_over("XOXXOOOX9", "X", 9) == false
  end

  test "game is over when X gets a row" do
    assert Board.game_over("XXXOO6789", "X", 6) == true
  end

  test "is checked when iterator is 3" do
    assert Board.is_checked?(3, 3) == true
  end

  test "is not checked when iterator is under 3" do
    assert Board.is_checked?(3, 2) == false
  end
end
