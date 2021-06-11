defmodule TicTacToeElixir.Repo.Migrations.CopyBoardDataToBoardsTable do
  use Ecto.Migration

  def change do
    execute "INSERT INTO boards(board_state) SELECT board_state FROM ttt_records;"
  end
end
