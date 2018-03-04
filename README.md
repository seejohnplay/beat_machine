# Sm808

An Elixir application that models the sequencer part of a drum machine.

## Requirements

* Mac OS X (for audio playback)
* Elixir 1.6 (Visit [https://elixir-lang.org](https://elixir-lang.org) for more information)

## Usage
To play the demo:

```shell
> cd sm808
> iex -S mix

iex(1)> Sm808.start_demo
iex(2)> # And when you're done listening:
iex(3)> Sm808.stop(v)
```
To create your own beats in IEX:
```shell
> cd sm808
> iex -S mix

iex(1)> alias Sm808.Song
iex(2)> song = Song.new(120, "New Song")
iex(3)> {:ok, song} = Song.add_pattern(song, [1,0,0,0], "kick")
iex(4)> {:ok, song} = Song.add_pattern(song, [0,0,0,0,1,0,0,0], "snare")
iex(5)> {:ok, song} = Song.add_pattern(song, [0,0,1,0,0,0,1,0], "hihat")
iex(6)> sequencer = Sequencer.new()
iex(7)> {:ok, sequencer} = Sequencer.start(sequencer, song)
iex(8)> # And when you're done listening:
iex(9)> Sequencer.stop(sequencer)
```
