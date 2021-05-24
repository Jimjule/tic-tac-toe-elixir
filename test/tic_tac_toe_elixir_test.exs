defmodule TicTacToeElixirTest do
  use ExUnit.Case
  doctest TicTacToeElixir

  test "greets the user" do
    assert TicTacToeElixir.greet() == "Welcome to TicTacToe - Elixir Edition!"
  end
end
