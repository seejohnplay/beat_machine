defmodule Sm808.Sequencer do
  alias Sm808.{Sequencer, Song, Pattern}

  defstruct [:pid]

  # Public API

  def new() do
    %Sequencer{}
  end

  def start(
        %Sequencer{pid: pid} = sequencer,
        %Song{patterns: patterns, bpm: bpm},
        start_at \\ 1,
        stop_at \\ 999
      ) do
    case is_pid(pid) && Process.alive?(pid) do
      false ->
        pid =
          spawn(fn ->
            start_at..stop_at
            |> Enum.each(fn tick ->
              play_notes(patterns, tick)
              tick(bpm)
            end)
          end)

        {:ok, %{sequencer | pid: pid}}

      true ->
        {:error, :already_running}
    end
  end

  def stop(%Sequencer{pid: pid} = sequencer) do
    case is_pid(pid) && Process.alive?(pid) do
      true ->
        Process.exit(sequencer.pid, :kill)
        {:ok, %{sequencer | pid: nil}}

      false ->
        {:error, :not_running}
    end
  end

  # Private

  defp play_notes([], _tick), do: IO.write("|")

  defp play_notes([pattern | patterns], tick) do
    step = Pattern.fetch_step(pattern, tick)

    case step.status do
      :off ->
        IO.write(" ")

      :on ->
        spawn(fn ->
          System.cmd("afplay", ["-v", "#{step.velocity}", "./samples/#{pattern.name}.wav"])
        end)

        IO.write(" #{pattern.name} ")
    end

    play_notes(patterns, tick)
  end

  defp tick(bpm, beats \\ 4, steps \\ 16) do
    Kernel.trunc(60 / bpm * beats / steps * 1000)
    |> :timer.sleep()
  end
end
