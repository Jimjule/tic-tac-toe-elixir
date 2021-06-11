defmodule TicTacToeElixir.Repo.Migrations.UpdateTttrecords do
  use Ecto.Migration

  def change do
    alter table(:ttt_records) do
      modify :player_one_name, :string, size: 3, null: false
      modify :player_two_name, :string, size: 3, null: false
      modify :player_one_marker, :string, size: 1, null: false
      modify :player_two_marker, :string, size: 1, null: false
      modify :board_state, :string, size: 100, null: false
      modify timestamps([type: :utc_datetime])
    end
    flush()
  end
end
