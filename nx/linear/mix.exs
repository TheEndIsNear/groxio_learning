defmodule Linear.MixProject do
  use Mix.Project

  def project do
    [
      app: :linear,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nx, "~> 0.1.0", sparse: "nx", override: true},
      {:exla, "~> 0.1.0-dev", github: "elixir-nx/nx", sparse: "exla", override: true}
    ]
  end
end
