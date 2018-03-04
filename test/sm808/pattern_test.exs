defmodule PatternTest do
  use ExUnit.Case

  alias Sm808.Pattern

  test "creating a new pattern with name and steps" do
    name = "kick"
    steps = [1, 0, 0, 0]
    pattern = Pattern.new(name, steps)

    assert pattern.name == name
    assert length(pattern.steps) == length(steps)
  end

  test "creating a new pattern with an invalid sample name" do
    name = "kick2"
    steps = [1, 0, 0, 0]
    {:error, message} = Pattern.new(name, steps)

    assert message == :sample_not_found
  end

  test "creating a new pattern with invalid steps" do
    name = "kick"
    steps = :not_a_list
    {:error, message} = Pattern.new(name, steps)

    assert message == :invalid_steps
  end

  test "fetching a step with incrementing ticks" do
    name = "kick"
    steps = [1, 0, 0, 0]
    pattern = Pattern.new(name, steps)

    assert Pattern.fetch_step(pattern, 1) == pattern.steps |> Enum.at(0)
    assert Pattern.fetch_step(pattern, 2) == pattern.steps |> Enum.at(1)
    assert Pattern.fetch_step(pattern, 3) == pattern.steps |> Enum.at(2)
    assert Pattern.fetch_step(pattern, 4) == pattern.steps |> Enum.at(3)
    assert Pattern.fetch_step(pattern, 5) == pattern.steps |> Enum.at(0)
  end

  test "fetching a step with an invalid tick" do
    name = "kick"
    steps = [1, 0, 0, 0]
    pattern = Pattern.new(name, steps)
    negative_tick = -1
    {:error, message} = Pattern.fetch_step(pattern, negative_tick)

    assert message == :invalid_tick
  end
end
