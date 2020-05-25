defmodule FractionTest do
  use ExUnit.Case
  doctest Fraction

  test "new" do
    assert Fraction.new(1, 2) === %Fraction{a: 1, b: 2}
  end

  test "value" do
    assert Fraction.new(2, 1) |> Fraction.value() === 2.0
    assert Fraction.new(3, 2) |> Fraction.value() === 1.5
  end

  test "add" do
    import Fraction
    assert add(new(2, 1), new(3, 1)) === %Fraction{a: 5, b: 1}
    assert add(new(3, 2), new(3, 1)) === %Fraction{a: 9, b: 2}
  end
end
