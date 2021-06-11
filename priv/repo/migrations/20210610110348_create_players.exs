defmodule TicTacToeElixir.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :player_name, :string, size: 3, null: false
      add :player_marker, :string, size: 1, null: false
    end
  end
end
