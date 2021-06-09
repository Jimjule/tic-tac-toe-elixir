defmodule TicTacToeElixir.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias TicTacToeElixir.Repo

      import Ecto
      import Ecto.Query
      import TicTacToeElixir.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TicTacToeElixir.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(TicTacToeElixir.Repo, {:shared, self()})
    end

    :ok
  end
end