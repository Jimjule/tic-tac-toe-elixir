use Mix.Config

config :tic_tac_toe_elixir, TicTacToeElixir.Repo,
       database: "tic_tac_toe_elixir_test",
       username: "postgres",
       password: "",
       hostname: "localhost",
       pool: Ecto.Adapters.SQL.Sandbox
