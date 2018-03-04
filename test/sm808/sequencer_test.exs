defmodule SequencerTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias Sm808.{Sequencer, Song, ScreenWriter}

  test "starting a sequencer with one pattern" do
    bpm = 1000
    title = "New Song"
    song = Song.new(bpm, title, [ScreenWriter])
    {:ok, song} = Sm808.Song.add_pattern(song, [1, 0, 0, 0], "kick")

    assert capture_io(fn ->
             Sequencer.play(song, 4)
           end) == " kick | | | |"
  end

  test "starting a sequencer with overlapping patterns" do
    bpm = 1000
    title = "New Song"
    song = Song.new(bpm, title, [Sm808.ScreenWriter])
    {:ok, song} = Sm808.Song.add_pattern(song, [1, 0, 0, 0], "kick")
    {:ok, song} = Sm808.Song.add_pattern(song, [0, 0, 0, 0, 1, 0, 0, 0], "snare")
    {:ok, song} = Sm808.Song.add_pattern(song, [0, 0, 1, 0, 0, 0, 1, 0], "hihat")

    assert capture_io(fn ->
             Sequencer.play(song, 8)
           end) == "   kick |   | hihat   |   |  snare  kick |   | hihat   |   |"
  end
end
