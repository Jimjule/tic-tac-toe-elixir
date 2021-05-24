defmodule TicTacToeElixirTest do
  use ExUnit.Case
  doctest TicTacToeElixir

  test "greets the world" do
    assert TicTacToeElixir.start() == :ok
  end
end
