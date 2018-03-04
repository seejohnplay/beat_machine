defmodule Sm808.Step do
  alias __MODULE__

  @enforce_keys [:status, :velocity]
  defstruct [:status, :velocity]

  # Public API

  def new(0) do
    %Step{status: :off, velocity: 0}
  end

  def new(velocity) when velocity < 0 do
    %Step{status: :off, velocity: 0}
  end

  def new(velocity) when velocity > 1 do
    %Step{status: :on, velocity: 1}
  end

  def new(velocity) do
    %Step{status: :on, velocity: velocity}
  end
end
