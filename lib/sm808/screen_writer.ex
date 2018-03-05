defmodule Sm808.ScreenWriter do
  @behaviour Sm808.Writer

  alias Sm808.Pattern

  # Public API

  def handle_steps([], 1), do: IO.write("|_|")

  def handle_steps(patterns, tick) do
    handle_steps(patterns, tick, [])
  end

  # Private

  defp handle_steps([], 1, acc) do
    IO.write("|" <> Enum.join(acc, "+") <> "|")
  end

  defp handle_steps([], _tick, []) do
    IO.write("_|")
  end

  defp handle_steps([], _tick, acc) do
    IO.write(Enum.join(acc, "+") <> "|")
  end

  defp handle_steps([pattern | patterns], tick, acc) do
    step = Pattern.fetch_step(pattern, tick)

    case step.status do
      :off ->
        handle_steps(patterns, tick, acc)

      :on ->
        handle_steps(patterns, tick, [pattern.name | acc])
    end
  end
end
