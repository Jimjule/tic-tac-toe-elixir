defmodule TicTacToeElixir.Repo.Migrations.CreateTttrecords do
  use Ecto.Migration

  def up do
    create table(:ttt_records) do
      add :player_one_name, :string, size: 3
      add :player_two_name, :string, size: 3
      add :player_one_marker, :string, size: 1
      add :player_two_marker, :string, size: 1
      add :board_state, :string, size: 100
      timestamps([type: :utc_datetime])
    end
  end

  def down do
    drop table("ttt_records")
  end
end
