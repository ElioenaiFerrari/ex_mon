defmodule ExMon.Game.Status do
  defp build_status(title, info) do
    IO.puts("\n===== #{title} =====\n")
    IO.inspect(info)
    IO.puts("------------------------")
  end

  defp build_status(title) do
    IO.puts("\n===== #{title} =====\n")
  end

  def print_round_message(%{status: :started} = info) do
    build_status("The game is started", info)
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    build_status("It's #{player} turn", info)
  end

  def print_round_message(%{status: :game_over, turn: player} = info) do
    build_status("The game is over - #{player} win", info)
  end

  def print_wrong_move_message(move) do
    build_status("Wrong move #{move}")
  end

  def print_move_message(:computer, :attack, damage) do
    build_status("The player attacked the computer dealing #{damage} damage")
  end

  def print_move_message(:player, :attack, damage) do
    build_status("The computer attacked the player dealing #{damage} damage")
  end

  def print_move_message(player, :heal, life) do
    build_status("The #{player} healled itself to #{life} life points")
  end
end
