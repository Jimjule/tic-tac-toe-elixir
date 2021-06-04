defmodule TicTacToeElixir.Repo do
  use Ecto.Repo,
    otp_app: :tic_tac_toe_elixir,
    adapter: Ecto.Adapters.Postgres
end
