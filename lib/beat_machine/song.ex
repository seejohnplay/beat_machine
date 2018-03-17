defmodule BeatMachine.Song do
  alias BeatMachine.{Song, Pattern, ScreenWriter, AudioWriter}

  @enforce_keys [:bpm, :title, :patterns]
  defstruct [:bpm, :title, :patterns, :writers]

  # Public API

  def new(bpm, title, writers \\ [ScreenWriter, AudioWriter]) do
    %Song{bpm: bpm, title: title, patterns: [], writers: writers}
  end

  def add_pattern(song = %Song{}, steps, sample_name) do
    pattern = Pattern.new(sample_name, steps)

    case pattern do
      {:error, message} ->
        {:error, message}

      _ ->
        patterns = [pattern | song.patterns]
        {:ok, %{song | patterns: patterns}}
    end
  end

  def handle_tick(%Song{patterns: patterns, writers: writers}, tick) do
    handle_tick(writers, patterns, tick)
  end

  # Private

  def handle_tick([], _, _), do: nil

  def handle_tick(BeatMachine.TestWriter = writer, patterns, tick) do
    writer.handle_steps(patterns, tick)
  end

  def handle_tick([writer | writers], patterns, tick) do
    writer.handle_steps(patterns, tick)
    handle_tick(writers, patterns, tick)
  end
end
