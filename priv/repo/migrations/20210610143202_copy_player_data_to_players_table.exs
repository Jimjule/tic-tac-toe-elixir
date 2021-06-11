defmodule TicTacToeElixir.Repo.Migrations.CopyPlayerDataToPlayersTable do
  use Ecto.Migration

  def change do
    execute "INSERT INTO players(player_name, player_marker) SELECT DISTINCT player_one_name, player_one_marker FROM ttt_records;"
    execute "INSERT INTO players(player_name, player_marker) SELECT DISTINCT player_two_name, player_two_marker FROM ttt_records;"
  end
end
