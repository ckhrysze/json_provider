defmodule JsonProviderTest do
  use ExUnit.Case

  test "handles top level application config" do
    config_path = Path.join([__DIR__, "json_config", "single.json"])
    assert :ok = JsonProvider.init(path: config_path)
    assert "top level!" == Application.fetch_env!(:json_provider, :top_level)
  end

  test "handles nested module config" do
    config_path = Path.join([__DIR__, "json_config", "module.json"])
    assert :ok = JsonProvider.init(path: config_path)
    config = Application.fetch_env!(:json_provider, Some.Nested.Module)
    assert "nested_attr" == get_in(config, [:attr])
  end
end
