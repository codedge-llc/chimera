[![Build Status](https://travis-ci.org/codedge-llc/chimera.svg?branch=master)](https://travis-ci.org/codedge-llc/chimera)
[![Hex.pm](http://img.shields.io/hexpm/v/chimera.svg)](https://hex.pm/packages/chimera)
[![Hex.pm](http://img.shields.io/hexpm/dt/chimera.svg)](https://hex.pm/packages/chimera)

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

Add `use Chimera` to your struct's module. It adds `new/1` and `new/2` functions
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

## Custom Mappings

Use the optional `:map` argument to specify custom key mappings.
`:map` is a keyword list whose keys correspond to the keys of
the destination struct.

```elixir
iex> user = %User{id: 1234, name: "Person", email: "person@example.com"}
iex> Profile.new(user, map: [name: nil])
%Profile{id: 1234, name: nil, avatar: nil}
```

Specify a function of arity 1 that takes the source struct as
a parameter:

```elixir
iex> user = %User{id: 1234, name: "Person", email: "person@example.com"}
iex> Profile.new(user, map: [name: fn user -> String.upcase(user.email) end])
%Profile{id: 1234, name: "PERSON", avatar: nil}
```
