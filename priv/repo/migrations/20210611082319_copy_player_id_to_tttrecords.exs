defmodule TicTacToeElixir.Repo.Migrations.CopyPlayerIdToTttrecords do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE ttt_records RENAME COLUMN player_one_two TO player_two_id;"
    execute "UPDATE ttt_records SET player_one_id = players.id FROM players WHERE ttt_records.player_one_name = players.player_name AND ttt_records.player_one_marker = players.player_marker";
    execute "UPDATE ttt_records SET player_two_id = players.id FROM players WHERE ttt_records.player_two_name = players.player_name AND ttt_records.player_two_marker = players.player_marker";
  end
end
