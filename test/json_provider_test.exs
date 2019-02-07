defmodule JsonProviderTest do
  use ExUnit.Case

  defp map_path(filename), do: [path: Path.join([__DIR__, "json_config", filename])]

  test "handles top level application config" do
    "single.json" |> map_path() |> JsonProvider.init()

    assert "top level!" == Application.fetch_env!(:json_provider, :top_level)
  end

  test "handles nested module config" do
    "module.json" |> map_path() |> JsonProvider.init()

    config = Application.fetch_env!(:json_provider, Some.Nested.Module)
    assert "nested_attr" == get_in(config, [:attr])
  end

  test "can convert atom typed value object to atom" do
    "atom_values.json" |> map_path() |> JsonProvider.init()

    mailer_config = Application.fetch_env!(:json_provider, :mailer)
    module_config = Application.fetch_env!(:json_provider, Some.Nested.Module)

    assert :"Elixir.A.Fake.Mailer" == get_in(mailer_config, [:adapter])
    assert :warn == get_in(module_config, [:log_level])
  end

  test "can convert charlist typed value object to charlist" do
    "charlist_values.json" |> map_path() |> JsonProvider.init()

    assert '/home/tester/directory' = Application.fetch_env!(:mnesia, :dir)
  end
end
