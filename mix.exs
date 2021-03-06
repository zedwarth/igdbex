defmodule Igdbex.Mixfile do
  use Mix.Project

  def project do
    [app: :igdbex,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test,
                         "coveralls.detail": :test,
                         "coveralls.post": :test,
                         "coveralls.html": :test]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison],
     mod: {Igdbex, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:excoveralls, "~> 0.5.2", only: [:dev, :test]},
     {:exvcr, "~> 0.7", only: [:dev, :test]},
     {:credo, "~> 0.3", only: [:dev, :test]},
     {:httpoison, "~> 0.8.0"},
     {:inch_ex, "~> 0.5.1", only: :docs},
     {:poison, "~> 2.0"}]
  end
end
