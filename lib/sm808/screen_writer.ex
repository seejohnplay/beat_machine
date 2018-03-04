defmodule Sm808.ScreenWriter do
  alias Sm808.Pattern

  # Public API

  def handle_steps([], _tick), do: IO.write("|")

  def handle_steps([pattern | patterns], tick) do
    step = Pattern.fetch_step(pattern, tick)

    case step.status do
      :off ->
        IO.write(" ")

      :on ->
        IO.write(" #{pattern.name} ")
    end

    handle_steps(patterns, tick)
  end
end
