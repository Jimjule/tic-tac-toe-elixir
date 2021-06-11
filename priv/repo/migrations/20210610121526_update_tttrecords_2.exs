defmodule TicTacToeElixir.Repo.Migrations.UpdateTttrecords2 do
  use Ecto.Migration

  def change do
    alter table(:ttt_records) do
      add :player_one_id, references(:players, on_delete: :delete_all)
      add :player_one_two, references(:players, on_delete: :delete_all)
    end
  end
end
