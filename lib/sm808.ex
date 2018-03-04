defmodule Sm808 do
  alias Sm808.{Song, Sequencer}

  def start_demo do
    song = Song.new(120, "Demo Song")
    {:ok, song} = Sm808.Song.add_pattern(song, [1, 0, 0, 0], "kick")
    {:ok, song} = Sm808.Song.add_pattern(song, [0, 0, 0, 0, 1, 0, 0, 0], "snare")
    {:ok, song} = Sm808.Song.add_pattern(song, [0, 0, 1, 0, 0, 0, 1, 0], "hihat")
    sequencer = Sequencer.new()
    {:ok, sequencer} = Sequencer.start(sequencer, song)
    sequencer
  end

  def stop_demo(sequencer) do
    Sequencer.stop(sequencer)
  end
end
