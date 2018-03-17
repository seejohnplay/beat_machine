defmodule SequencerTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias BeatMachine.{Sequencer, Song, ScreenWriter}

  test "starting a sequencer with one pattern" do
    bpm = 1000
    title = "New Song"
    song = Song.new(bpm, title, [ScreenWriter])
    {:ok, song} = BeatMachine.Song.add_pattern(song, [1, 0, 0, 0], "kick")

    assert capture_io(fn ->
             Sequencer.play(song, 4)
           end) == "|kick|_|_|_|"
  end

  test "starting a sequencer with overlapping patterns" do
    bpm = 1000
    title = "New Song"
    song = Song.new(bpm, title, [BeatMachine.ScreenWriter])
    {:ok, song} = BeatMachine.Song.add_pattern(song, [1, 0, 0, 0], "kick")
    {:ok, song} = BeatMachine.Song.add_pattern(song, [0, 0, 0, 0, 1, 0, 0, 0], "snare")
    {:ok, song} = BeatMachine.Song.add_pattern(song, [0, 0, 1, 0, 0, 0, 1, 0], "hihat")

    assert capture_io(fn ->
             Sequencer.play(song, 8)
           end) == "|kick|_|hihat|_|kick+snare|_|hihat|_|"
  end
end
