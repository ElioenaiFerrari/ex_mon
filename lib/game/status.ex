defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message() do
    IO.puts("The game is started")
    Game.info()
  end

  def print_wrong_move_message(move), do: "Wrong move #{move}"
end
