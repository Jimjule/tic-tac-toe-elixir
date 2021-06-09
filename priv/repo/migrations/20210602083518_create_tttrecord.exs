defmodule TicTacToeElixir.Repo.Migrations.CreateTttrecords do
  use Ecto.Migration

  def change do
    create table(:ttt_records) do
      add :player_one_name, :string, size: 3, null: false
      add :player_two_name, :string, size: 3, null: false
      add :player_one_marker, :string, size: 1, null: false
      add :player_two_marker, :string, size: 1, null: false
      add :board_state, :string, size: 100, null: false
      add timestamps([type: :utc_datetime]), null: false
    end
  end
end
