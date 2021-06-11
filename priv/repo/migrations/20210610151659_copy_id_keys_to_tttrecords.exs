defmodule TicTacToeElixir.Repo.Migrations.CopyIdKeysToTttrecords do
  use Ecto.Migration

  def change do
    execute "UPDATE ttt_records SET board_state_id = boards.id FROM boards WHERE ttt_records.board_state = boards.board_state";
  end
end
