defmodule Timer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Timer.Server

  @impl true
  def start(_type, _args) do
    children = [
      %{id: Server, start: {Server, :start_link, [[]]}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Timer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
