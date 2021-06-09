import Config

config :tic_tac_toe_elixir, TicTacToeElixir.Repo,
  database: "tic_tac_toe_elixir_repo",
  hostname: "localhost"

config :tic_tac_toe_elixir, :"TicTacToeElixir.repo",
  database: "tic_tac_toe_elixir_repo",
  hostname: "localhost"

config :tic_tac_toe_elixir, ecto_repos: [TicTacToeElixir.Repo]

import_config "#{Mix.env()}.exs"