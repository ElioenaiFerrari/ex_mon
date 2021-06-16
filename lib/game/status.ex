defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message() do
    IO.puts("The game is started")
    Game.info()
  end

  def print_wrong_move_message(move), do: "Wrong move #{move}"

  def print_move_message(:computer, :attack, damage) do
    "The player attacked the computer dealing #{damage} damage"
  end

  def print_move_message(:player, :attack, damage) do
    "The computer attacked the player dealing #{damage} damage"
  end
end
