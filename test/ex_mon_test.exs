defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "create_player/4" do
    test "returns a player" do
      player = ExMon.create_player("Eli", :punch, :kick, :heal)

      assert player == %ExMon.Player{
               life: 100,
               moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
               name: "Eli"
             }
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = ExMon.create_player("Eli", :punch, :kick, :heal)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = ExMon.create_player("Eli", :punch, :kick, :heal)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:punch)
        end)

      assert messages =~ "The player attacked the computer dealing"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns a error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong_move)
        end)

      assert messages =~ "Wrong move wrong_move"
    end
  end
end
