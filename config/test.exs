use Mix.Config

config :tic_tac_toe_elixir, TicTacToeElixir.Repo,
       database: "tic_tac_toe_elixir_test",
       hostname: "localhost",
       pool: Ecto.Adapters.SQL.Sandbox
