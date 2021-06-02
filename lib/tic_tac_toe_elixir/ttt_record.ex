defmodule TicTacToeElixir.Ttt_record do
  use Ecto.Schema
  @timestamps_opts [type: :utc_datetime]

  schema "ttt_records" do
    field :player_one_name, :string, size: 3
    field :player_two_name, :string, size: 3
    field :player_one_marker, :string, size: 1
    field :player_two_marker, :string, size: 1
    field :board_state, :string, size: 100
    timestamps()
  end
end