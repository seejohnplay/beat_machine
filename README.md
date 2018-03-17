# BeatMachine

An Elixir application that models the sequencer part of a drum machine.

Drum samples courtesy of [99sounds.org](http://99sounds.org/drum-samples/).

## Requirements

* Mac OS X (for audio playback)
* Elixir 1.6 (Visit [https://elixir-lang.org](https://elixir-lang.org) for more information)

## Run the tests

```shell
> cd beat_machine
> mix test
```

## Usage
To play the demos:

```shell
> mix escript.build
> ./beat_machine
```
To create your own beats in IEX:
```shell
> cd beat_machine
> iex -S mix

iex(1)> alias BeatMachine.{Song, Sequencer}
iex(2)> song = Song.new(120, "New Song")
iex(3)> {:ok, song} = Song.add_pattern(song, [1, 0, 0], "kick")
iex(4)> {:ok, song} = Song.add_pattern(song, [0, 0, 0, 0, 1, 0.2, 0, 0], "snare")
iex(5)> {:ok, song} = Song.add_pattern(song, [0.2, 0, 1, 0.2, 0.2, 0.2, 1, 0.2], "hihat")
iex(6)> Sequencer.play(song)
```

![Output example](/drummachine.gif)