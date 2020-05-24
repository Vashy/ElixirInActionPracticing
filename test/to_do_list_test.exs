defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  test "Creating new data Abstraction" do
    assert TodoList.new() === %{}
  end

  test "Adding a single new entry" do
    added_entry = TodoList.new() |> TodoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
    assert added_entry === %{{2013, 12, 19} => ["Dentist"]}
  end

  test "Adding multiple entries to the same key" do
    add_entry =
      TodoList.new()
      |> TodoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
      |> TodoList.add_entry(%{date: {2013, 12, 19}, title: "Grocery shopping"})

    assert add_entry === %{{2013, 12, 19} => ["Grocery shopping", "Dentist"]}
  end

  test "entries() which returns the value of a given key" do
    entries =
      TodoList.new()
      |> TodoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
      |> TodoList.add_entry(%{date: {2013, 12, 19}, title: "Grocery shopping"})

    assert TodoList.entries(entries, {2013, 12, 19}) === ["Grocery shopping", "Dentist"]
  end
end
