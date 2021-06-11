defmodule TicTacToeElixir.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :board_state, :string, null: false
    end
  end
end
