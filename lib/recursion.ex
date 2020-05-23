defmodule Recursion do
  @moduledoc """
  Non-tailrecursive version of `ElixirInActionPracticing`.
  """

  @doc """
  Computes the `length` of a list. 

  Complexity: `O(n)`
  """
  @spec list_len(list()) :: integer()
  def list_len([]), do: 0

  def list_len([_ | tail]) do
    1 + list_len(tail)
  end

  @doc """
  Returns a `list` containing all elements included in `from..to`

  Complexity: `O(n)`
  """
  @spec range(integer(), integer()) :: list()
  def range(x, x), do: [x]

  def range(from, to) when from < to do
    [from | range(from + 1, to)]
  end

  def range(from, to) when from > to, do: {:error, "Invalid range #{from}..#{to}"}

  @doc """
  Filter all the non-positive elements in the `list`.

  Complexity: `O(n)`
  """
  @spec filter_positive(list()) :: list()
  def filter_positive([]), do: []

  def filter_positive([head | tail]) when head >= 0 do
    [head | filter_positive(tail)]
  end

  def filter_positive([_ | tail]), do: filter_positive(tail)
end
