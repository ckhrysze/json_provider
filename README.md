[![Build Status](https://travis-ci.org/ckhrysze/json_provider.svg?branch=master)](https://travis-ci.org/ckhrysze/json_provider)

# JsonProvider

**A json provider for distillery 2 using the jason library**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `json_provider` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:json_provider, "~> 0.3.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/json_provider](https://hexdocs.pm/json_provider).

## Usage notes

Most JSON types map as expected. However, specific JSON objects can be used to
have atoms or charlists in the final config output.

#### charlist
```json
{
  "mnesia": {
    "dir": {
      "type": "charlist",
      "value": "/home/tester/directory"
    }
  }
}
```

#### atom
```json
{
  "Elixir.Some.Nested.Module": {
    "log_level": {
      "type": "atom",
      "value": "warn"
    }
  }
}
```
