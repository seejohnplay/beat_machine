defmodule Sm808.AudioWriter do
  alias Sm808.Pattern

  # Public API

  def handle_steps([], _tick), do: nil

  def handle_steps([pattern | patterns], tick) do
    step = Pattern.fetch_step(pattern, tick)

    case step.status do
      :on ->
        spawn(fn ->
          System.cmd("afplay", ["-v", "#{step.velocity}", "./samples/#{pattern.name}.wav"])
        end)

      :off ->
        nil
    end

    handle_steps(patterns, tick)
  end
end
