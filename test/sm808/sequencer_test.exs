defmodule SequencerTest do
  use ExUnit.Case
  doctest Sm808

  alias Sm808.{Sequencer, Song}

  test "creating a new sequencer" do
    sequencer = Sequencer.new()

    assert sequencer.pid == nil
  end

  test "starting a new sequencer" do
    bpm = 120
    title = "New Song"
    song = Song.new(bpm, title)
    sequencer = Sequencer.new()
    {:ok, sequencer} = Sequencer.start(sequencer, song)

    assert Process.alive?(sequencer.pid)

    # Teardown
    {:ok, _sequencer} = Sequencer.stop(sequencer)
  end

  test "attemping to start a sequencer already running" do
    bpm = 120
    title = "New Song"
    song = Song.new(bpm, title)
    sequencer = Sequencer.new()
    {:ok, sequencer} = Sequencer.start(sequencer, song)
    {:error, message} = Sequencer.start(sequencer, song)

    assert message == :already_running

    # Teardown
    {:ok, _sequencer} = Sequencer.stop(sequencer)
  end

  test "stopping a sequencer that's running" do
    bpm = 120
    title = "New Song"
    song = Song.new(bpm, title)
    sequencer = Sequencer.new()
    {:ok, sequencer} = Sequencer.start(sequencer, song)
    {:ok, sequencer} = Sequencer.stop(sequencer)

    assert sequencer.pid == nil
  end

  test "attemping to stop a sequencer not currently running" do
    bpm = 120
    title = "New Song"
    song = Song.new(bpm, title)
    sequencer = Sequencer.new()
    {:ok, sequencer} = Sequencer.start(sequencer, song)
    {:ok, _sequencer} = Sequencer.stop(sequencer)
    {:error, message} = Sequencer.stop(sequencer)

    assert message == :not_running
  end
end
