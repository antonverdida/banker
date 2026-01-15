defmodule Banker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BankerWeb.Telemetry,
      Banker.Repo,
      {DNSCluster, query: Application.get_env(:banker, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Banker.PubSub},
      # Start a worker by calling: Banker.Worker.start_link(arg)
      # {Banker.Worker, arg},
      # Start to serve requests, typically the last entry
      BankerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Banker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BankerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
