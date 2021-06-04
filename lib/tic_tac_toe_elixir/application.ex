defmodule TicTacToeElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
#  alias TicTacToeElixir.Worker

  def start(_type, _args) do
    children = [
      TicTacToeElixir.Repo,
    ]
    opts = [strategy: :one_for_one, name: TicTacToe.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
