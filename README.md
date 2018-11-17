# Chimera

Dead-simple conversion between Elixir structs

## Installation

Add chimera as a mix.exs dependency:

```elixir
def deps do
  [
    {:chimera, "~> 0.1.0"}
  ]
end
```

## Usage

Add `use Chimera` to your struct's module. It adds a `new/1` function
that will create a new struct from any given map, struct or keyword list.

```elixir
defmodule User do
  defstruct id: nil, name: nil, email: nil
  use Chimera
end

defmodule Profile do
  defstruct id: nil, name: "Person", avatar: nil
  use Chimera
end

iex> User.new(id: 1234, name: "Person")
%User{id: 1234, name: "Person", email: nil}

iex> user = %User{id: 1234, name: "Person", email: "person@example.com"}
iex> Profile.new(user)
%Profile{id: 1234, name: "Person", avatar: nil}
```
