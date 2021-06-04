defmodule Database do
  def connect() do
    TicTacToeElixir.Repo.start_link()
    "\nDatabase: Started Link"
  end

  def get_all_records() do
    TicTacToeElixir.Ttt_record |> TicTacToeElixir.Repo.all
  end

  def get_record_by_id(id) do
    TicTacToeElixir.Ttt_record |> TicTacToeElixir.Repo.get(id)
  end
end