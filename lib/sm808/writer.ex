defmodule Sm808.Writer do
  @callback handle_steps([Sm808.Pattern], integer) :: none
end
