defmodule BeatMachine.CLI do
  @defaults [name: "demo1", steps: 32]

  def main(argv) do
    argv
    |> parse_args()
    |> print_usage()
    |> run()
    |> IO.puts()
  end

  def run(%{name: name, steps: steps}), do: BeatMachine.demo(name, steps)

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [name: :string, steps: :integer])
    Keyword.merge(@defaults, options) |> Enum.into(%{})
  end

  def print_usage(argv) do
    IO.puts("Usage:")
    IO.puts(" ./beat_machine [option...]")
    IO.puts(" ./beat_machine --name demo2")
    IO.puts(" ./beat_machine --name demo1 --steps 10")
    IO.puts("Options:")
    IO.puts("--name VALUE\tPlay a specific demo (demo1 or demo2) [default: demo1]")
    IO.puts("--steps VALUE\tPlay for specified number of steps [default: 32]")
    IO.puts("")
    argv
  end
end
