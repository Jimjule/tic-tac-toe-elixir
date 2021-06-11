defmodule TicTacToeElixir.Repo.Migrations.AddBoardIdToTttrecords do
  use Ecto.Migration

  def change do
    alter table(:ttt_records) do
      add :board_state_id, references(:boards, on_delete: :delete_all)
    end
  end
end
