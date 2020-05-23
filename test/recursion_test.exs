defmodule RecursionTest.Range do
  use ExUnit.Case
  doctest Recursion

  test "single element range" do
    assert Recursion.range(1, 1) === [1]
  end

  test "normal range" do
    assert Recursion.range(1, 5) === [1, 2, 3, 4, 5]
  end

  test "invalid range" do
    assert Recursion.range(5, 1) === {:error, "Invalid range 5..1"}
  end
end

defmodule RecursionTest.Listlen do
  use ExUnit.Case
  doctest Recursion

  test "4 elements list length should be 4" do
    assert Recursion.list_len([1, 2, 3, 5]) === 4
  end

  test "empty list length should be 0" do
    assert Recursion.list_len([]) === 0
  end
end

defmodule RecursionTest.FilterPositive do
  use ExUnit.Case
  doctest Recursion

  test "only positives list remains the same" do
    assert Recursion.filter_positive([1, 2, 3, 5]) === [1, 2, 3, 5]
  end

  test "empty list remains the same" do
    assert Recursion.filter_positive([]) === []
  end

  test "filters away all negative numbers" do
    assert Recursion.filter_positive([1, -2, 3, -5]) === [1, 3]
  end
end
