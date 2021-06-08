import Config

config :tic_tac_toe_elixir, ecto_repos: [TicTacToeElixir.Repo]

import_config "#{Mix.env()}.exs"