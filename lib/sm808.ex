defmodule Sm808 do
  alias Sm808.{Song, Sequencer}

  # Public API

  def demo("demo1", steps), do: demo1(steps)
  def demo("demo2", steps), do: demo2(steps)
  def demo(_, _), do: IO.puts("Unknown demo name.")

  # Private

  defp demo1(steps) do
    song = Song.new(120, "Demo Song 1")
    {:ok, song} = Sm808.Song.add_pattern(song, [1, 0, 0, 0], "kick")
    {:ok, song} = Sm808.Song.add_pattern(song, [0, 0, 0, 0, 1, 0, 0, 0], "snare")
    {:ok, song} = Sm808.Song.add_pattern(song, [0, 0, 1, 0, 0, 0, 1, 0], "hihat")
    Sequencer.play(song, steps)
  end

  defp demo2(steps) do
    song = Song.new(90, "Demo Song 2")
    {:ok, song} = Sm808.Song.add_pattern(song, [1, 0, 0], "kick")
    {:ok, song} = Sm808.Song.add_pattern(song, [0, 0, 0, 0, 1, 0.2, 0, 0], "snare")
    {:ok, song} = Sm808.Song.add_pattern(song, [0.2, 0, 1, 0.2, 0.2, 0.2, 1, 0.2], "hihat")
    Sequencer.play(song, steps)
  end
end
