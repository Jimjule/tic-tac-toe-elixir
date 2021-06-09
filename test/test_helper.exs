ExUnit.start()

TicTacToeElixir.Repo.start_link()

Ecto.Adapters.SQL.Sandbox.mode(TicTacToeElixir.Repo, :auto)
