defmodule BeatMachine.Writer do
  @callback handle_steps([BeatMachine.Pattern], integer) :: none
end
