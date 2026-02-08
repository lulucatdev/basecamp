defmodule Basecamp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {NodeJS.Supervisor, [path: LiveVue.SSR.NodeJS.server_path(), pool_size: 4]},
      BasecampWeb.Telemetry,
      Basecamp.Repo,
      {DNSCluster, query: Application.get_env(:basecamp, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Basecamp.PubSub},
      # Start a worker by calling: Basecamp.Worker.start_link(arg)
      # {Basecamp.Worker, arg},
      # Start to serve requests, typically the last entry
      BasecampWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Basecamp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BasecampWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
