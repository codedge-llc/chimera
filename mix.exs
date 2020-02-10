defmodule Chimera.MixProject do
  use Mix.Project

  @version "0.3.0"

  def project do
    [
      app: :chimera,
      version: @version,
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      source_url: "https://github.com/codedge-llc/chimera",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.2", only: :dev},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    """
    Dead-simple conversion between structs
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Henry Popp"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/codedge-llc/chimera"}
    ]
  end
end
