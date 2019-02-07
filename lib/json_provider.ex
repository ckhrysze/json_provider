defmodule JsonProvider do
  @moduledoc """
  A JSON config provider for Distillery 2
  """

  def init(path: config_path) do
    config_path = Path.expand(config_path)

    if File.exists?(config_path) do
      config_path
      |> File.read!()
      |> Jason.decode!()
      |> to_keyword()
      |> persist()
    else
      exit("Error reading json config")
    end
  end

  defp to_keyword(%{"type" => "atom", "value" => value} = c) when map_size(c) == 2,
    do: String.to_atom(value)

  defp to_keyword(%{"type" => "charlist", "value" => value} = c) when map_size(c) == 2,
    do: String.to_charlist(value)

  defp to_keyword(config) when is_map(config) do
    for {k, v} <- config do
      k = String.to_atom(k)
      {k, to_keyword(v)}
    end
  end

  defp to_keyword(config), do: config

  defp persist(config) do
    for {app, app_config} <- config do
      base_config = Application.get_all_env(app)
      merged = deep_merge(base_config, app_config)

      for {k, v} <- merged do
        Application.put_env(app, k, v, persistent: true)
      end
    end

    :ok
  end

  defp deep_merge(a, b) when is_list(a) and is_list(b) do
    if Keyword.keyword?(a) and Keyword.keyword?(b) do
      Keyword.merge(a, b, &deep_merge/3)
    else
      b
    end
  end

  defp deep_merge(_k, a, b) when is_list(a) and is_list(b) do
    if Keyword.keyword?(a) and Keyword.keyword?(b) do
      Keyword.merge(a, b, &deep_merge/3)
    else
      b
    end
  end

  defp deep_merge(_k, a, b) when is_map(a) and is_map(b) do
    Map.merge(a, b, &deep_merge/3)
  end

  defp deep_merge(_k, _a, b), do: b
end
