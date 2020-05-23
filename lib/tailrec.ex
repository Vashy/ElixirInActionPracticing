defmodule Recursion.Tail do
  @moduledoc """
  Tailrecursive version of `ElixirInActionPracticing`.
  """

  @doc """
  Computes the `length` of a list. 

  Complexity: `O(n)`
  """
  @spec list_len(list()) :: integer()
  def list_len(list), do: list_len(list, 0)

  defp list_len([], acc), do: acc

  defp list_len([_ | tail], acc) do
    list_len(tail, acc + 1)
  end

  @doc """
  Returns a `list` containing all elements included in `from..to`

  Complexity: `O(n)`
  """
  @spec range(integer(), integer()) :: list()
  def range(from, to) when from <= to, do: range(to, from, [])

  def range(from, to) when from > to, do: {:error, "Invalid range #{from}..#{to}"}

  defp range(x, x, list), do: [x | list]

  defp range(to, from, list) when to > from do
    range(to - 1, from, [to | list])
  end

  @doc """
  Filter all the non-positive elements in the `list`.

  Complexity: `O(n)`
  """
  @spec filter_positive(list()) :: list()
  def filter_positive(list) do
    list
    |> filter_positive([])
    |> invert
  end

  defp filter_positive([], acc), do: acc

  defp filter_positive([head | tail], acc) when head >= 0 do
    filter_positive(tail, [head | acc])
  end

  defp filter_positive([_ | tail], acc) do
    filter_positive(tail, acc)
  end

  defp invert(list), do: invert(list, [])
  defp invert([], acc), do: acc
  defp invert([head | tail], acc), do: invert(tail, [head | acc])
end
