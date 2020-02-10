defmodule Chimera do
  @moduledoc false

  defmacro __using__(_) do
    quote location: :keep do
      def new(from, opts \\ [])

      def new(from, opts) when is_atom(from) do
        new(struct(from), opts)
      end

      def new(from, opts) when is_map(from) or is_list(from) do
        __MODULE__
        |> struct(from)
        |> mapper(from, Keyword.get(opts, :map, []))
      end

      defp mapper(to, from, []), do: to

      defp mapper(to, from, [{key, fun} | rest]) when is_function(fun) do
        to
        |> Map.put(key, fun.(from))
        |> mapper(from, rest)
      end

      defp mapper(to, from, [{key, val} | rest]) do
        to
        |> Map.put(key, val)
        |> mapper(from, rest)
      end

      defimpl Enumerable, for: __MODULE__ do
        def count(map) do
          {:ok, map_size(map)}
        end

        def member?(map, {key, value}) do
          {:ok, match?(%{^key => ^value}, map)}
        end

        def member?(_map, _other) do
          {:ok, false}
        end

        def slice(map) do
          {:ok, map_size(map), &Enum.slice(:maps.to_list(map), &1, &2)}
        end

        def reduce(map, acc, fun) do
          reduce_list(:maps.to_list(map), acc, fun)
        end

        defp reduce_list(_list, {:halt, acc}, _fun), do: {:halted, acc}

        defp reduce_list(list, {:suspend, acc}, fun),
          do: {:suspended, acc, &reduce_list(list, &1, fun)}

        defp reduce_list([], {:cont, acc}, _fun), do: {:done, acc}

        defp reduce_list([head | tail], {:cont, acc}, fun),
          do: reduce_list(tail, fun.(head, acc), fun)
      end
    end
  end
end
