defmodule TicTacToeElixirTest do
  use ExUnit.Case
  doctest TicTacToeElixir

  test "greets the world" do
    assert TicTacToeElixir.greet() == "Welcome to TicTacToe - Elixir Edition!"
  end

  test "start is ok" do
    assert TicTacToeElixir.start() == :ok
  end
end
