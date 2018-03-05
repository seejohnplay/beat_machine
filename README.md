# Sm808

An Elixir application that models the sequencer part of a drum machine.

## Requirements

* Mac OS X (for audio playback)
* Elixir 1.6 (Visit [https://elixir-lang.org](https://elixir-lang.org) for more information)

## Run the tests

```shell
> cd sm808
> mix test
```

## Usage
To play the demos:

```shell
> mix escript.build
> ./sm808
```
To create your own beats in IEX:
```shell
> cd sm808
> iex -S mix

iex(1)> alias Sm808.Song
iex(2)> song = Song.new(120, "New Song")
iex(3)> {:ok, song} = Sm808.Song.add_pattern(song, [1, 0, 0], "kick")
iex(4)> {:ok, song} = Sm808.Song.add_pattern(song, [0, 0, 0, 0, 1, 0.2, 0, 0], "snare")
iex(5)> {:ok, song} = Sm808.Song.add_pattern(song, [0.2, 0, 1, 0.2, 0.2, 0.2, 1, 0.2], "hihat")
iex(6)> Sequencer.play(song)
```
