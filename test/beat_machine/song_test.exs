defmodule SongTest do
  use ExUnit.Case

  alias BeatMachine.Song

  test "creating a new song with BPM and title" do
    bpm = 120
    title = "New Song"
    song = Song.new(bpm, title)

    assert song.bpm == bpm
    assert song.title == title
  end

  test "creating a new song with an empty pattern list" do
    bpm = 120
    title = "New Song"
    song = Song.new(bpm, title)

    assert song.patterns == []
  end

  test "adding a valid pattern to a song" do
    bpm = 120
    title = "New Song"
    song = Song.new(bpm, title)
    {:ok, song} = BeatMachine.Song.add_pattern(song, "kick", [1, 0, 0, 0])

    assert length(song.patterns) == 1
  end

  test "adding a invalid pattern to a song returns an error" do
    bpm = 120
    title = "New Song"
    song = Song.new(bpm, title)
    {:error, message} = BeatMachine.Song.add_pattern(song, "kick", :not_a_list)

    assert message == :invalid_steps
    assert length(song.patterns) == 0
  end
end
