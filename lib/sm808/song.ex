defmodule Sm808.Song do
  alias Sm808.{Song, Pattern}

  @enforce_keys [:bpm, :title, :patterns]
  defstruct [:bpm, :title, :patterns]

  # Public API

  def new(bpm, title) do
    %Song{bpm: bpm, title: title, patterns: []}
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
end
