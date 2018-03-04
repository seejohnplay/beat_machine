defmodule Sm808.Pattern do
  alias Sm808.{Pattern, Step}

  @enforce_keys [:name, :steps]
  defstruct [:name, :steps]

  # Public API

  def new(name, steps) do
    case File.exists?("./samples/#{name}.wav") do
      true ->
        steps = import_steps(steps)

        case steps do
          {:error, message} ->
            {:error, message}

          _ ->
            %Pattern{name: name, steps: steps}
        end

      false ->
        {:error, :sample_not_found}
    end
  end

  def fetch_step(pattern, tick) do
    pattern
    |> step(tick)
  end

  # Private

  defp import_steps(steps) when is_list(steps) do
    steps
    |> Enum.map(fn step -> Step.new(step) end)
  end

  defp import_steps(_) do
    {:error, :invalid_steps}
  end

  defp step(pattern, tick) when tick > 0 do
    pattern.steps
    |> step_at_tick(tick)
  end

  defp step(_, _) do
    {:error, :invalid_tick}
  end

  defp step_at_tick(steps, tick) do
    steps
    |> Enum.at(index(steps, tick))
  end

  defp index(steps, tick) do
    rem(tick - 1, length(steps))
  end
end
