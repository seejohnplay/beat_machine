defmodule StepTest do
  use ExUnit.Case
  doctest Sm808

  alias Sm808.Step

  test "creating a new step with a velocity of 0 sets the status to :off" do
    velocity = 0
    step = Step.new(velocity)

    assert step.status == :off
  end

  test "creating a new step with a velocity of 1 sets the status to :on" do
    velocity = 1
    step = Step.new(velocity)

    assert step.status == :on
  end

  test "creating a new step with a velocity greater than 0 sets the status to :on" do
    velocity = 0.5
    step = Step.new(velocity)

    assert step.status == :on
  end

  test "creating a new step with a velocity of 1 sets the velocity to 1" do
    velocity = 1
    step = Step.new(velocity)

    assert step.velocity == 1
  end

  test "creating a new step with a velocity greater than 1 sets the velocity to 1" do
    velocity = 100
    step = Step.new(velocity)

    assert step.velocity == 1
  end

  test "creating a new step with a negative velocity sets the velocity to 0" do
    velocity = -100
    step = Step.new(velocity)

    assert step.velocity == 0
  end
end
