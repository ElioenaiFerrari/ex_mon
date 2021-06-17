defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Eli", :punch, :kick, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Eli", :punch, :kick, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      expected = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Robotinik"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Eli"
        },
        status: :started,
        turn: :player
      }

      Game.start(computer, player)

      assert Game.info() == expected
    end
  end

  describe "update/1" do
    test "returns the updated game state" do
      player = Player.build("Eli", :punch, :kick, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      old_state = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Robotinik"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Eli"
        },
        status: :started,
        turn: :player
      }

      Game.start(computer, player)

      assert Game.info() == old_state

      new_state = %{
        computer: %ExMon.Player{
          life: 85,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Robotinik"
        },
        player: %ExMon.Player{
          life: 50,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Eli"
        },
        status: :continue,
        turn: :player
      }

      assert old_state != Game.update(new_state)

      expected =
        new_state
        |> Map.put(:turn, :computer)
        |> Map.put(:status, :continue)

      assert expected == Game.info()
    end
  end

  describe "fetch_player/1" do
    test "returns a player" do
      player = Player.build("Eli", :punch, :kick, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      Game.start(computer, player)

      assert Game.fetch_player(:player) == player
      assert Game.fetch_player(:computer) == computer
    end
  end

  describe "turn/0" do
    test "returns a player" do
      player = Player.build("Eli", :punch, :kick, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      Game.start(computer, player)

      assert Game.turn() == :player

      new_state =
        Game.info()
        |> Map.put(:turn, :computer)
        |> Map.put(:status, :continue)

      assert %{turn: :computer, status: :continue} = new_state
    end
  end
end
