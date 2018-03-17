defmodule BeatMachine.Sequencer do
  alias BeatMachine.Song

  # Public API

  def play(song, song_length \\ 32), do: play(song, song_length, 1)

  def play(_, 0, _), do: nil

  def play(%Song{bpm: bpm} = song, song_length, tick) do
    Song.handle_tick(song, tick)
    tick(bpm)

    play(song, song_length - 1, tick + 1)
  end

  # Private

  defp tick(bpm, beats \\ 4, steps \\ 16) do
    Kernel.trunc(60 / bpm * beats / steps * 1000)
    |> :timer.sleep()
  end
end
