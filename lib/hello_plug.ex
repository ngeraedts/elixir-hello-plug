defmodule HelloPlug do
  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: HelloPlug.Router, options: [port: 4002])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloPlug]
    Supervisor.start_link(children, opts)
  end
end
