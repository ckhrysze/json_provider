defmodule JsonProvider.MixProject do
  use Mix.Project

  def project do
    [
      app: :json_provider,
      version: "0.1.0",
      elixir: "~> 1.7",
      description: "A json provider for distillery 2 using jason",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.1"},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Chris Hildebrand"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ckhrysze/json_provider"}
    ]
  end
end
