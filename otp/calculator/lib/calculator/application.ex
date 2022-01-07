defmodule Calculator.Application do
  use Application
  alias Calculator.Server

  @impl true
  def start(_type, _args) do
    children = [
      %{
        id: Server,
        start: {Server, :start_link, [0]}
      }
    ]

    opts = [strategy: :one_for_one, name: Calculator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
