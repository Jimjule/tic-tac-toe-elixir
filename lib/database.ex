import Ecto.Query

defmodule Database do
  def connect() do
    TicTacToeElixir.Repo.start_link()
    "\nDatabase: Started Link"
  end

  def get_all_records(), do: TicTacToeElixir.Ttt_record |> TicTacToeElixir.Repo.all

  def get_record_by_id(id), do: TicTacToeElixir.Ttt_record |> TicTacToeElixir.Repo.get(id)

  def get_records_by_player_name(name),
      do: TicTacToeElixir.Ttt_record |> Ecto.Query.where(player_one_name: ^name) |> or_where(player_two_name: ^name) |> TicTacToeElixir.Repo.all
end