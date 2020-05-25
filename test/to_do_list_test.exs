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

defmodule RefactoredTodoList.Test do
  use ExUnit.Case
  doctest RefactoredTodoList

  alias RefactoredTodoList, as: TodoList

  test "new" do
    assert TodoList.new() === %TodoList{auto_id: 1, entries: %{}}
  end

  test "add entry" do
    todo_list = TodoList.new() |> TodoList.add_entry(%{title: "My Title"})
    assert todo_list === %TodoList{auto_id: 2, entries: %{1 => %{id: 1, title: "My Title"}}}
  end

  test "entries on a given date" do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: {2020, 11, 13}, title: "Title 1"})
      |> TodoList.add_entry(%{date: {2020, 11, 13}, title: "Title 2"})
      |> TodoList.add_entry(%{date: {2020, 11, 15}, title: "Title on another date"})

    assert TodoList.entries(todo_list, {2020, 11, 13}) ===
             [
               %{date: {2020, 11, 13}, id: 1, title: "Title 1"},
               %{date: {2020, 11, 13}, id: 2, title: "Title 2"}
             ]
  end

  test "no entries matched" do
    result =
      TodoList.new()
      |> TodoList.entries({2020, 10, 10})

    assert result === []
  end

  test "update_entries/3" do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: {2020, 11, 13}, title: "Title 1"})

    assert todo_list
           |> TodoList.update_entry(1, &Map.put(&1, :date, {2013, 12, 20})) === %TodoList{
             auto_id: 2,
             entries: %{1 => %{date: {2013, 12, 20}, id: 1, title: "Title 1"}}
           }
  end

  test "update_entries/2" do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: {2020, 11, 13}, title: "Title 1"})

    assert todo_list
           |> TodoList.update_entry(%{id: 1, date: {2013, 12, 20}, title: "Title 1"}) === %TodoList{
             auto_id: 2,
             entries: %{1 => %{date: {2013, 12, 20}, id: 1, title: "Title 1"}}
           }
  end

  test "delete entry" do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: {2020, 11, 13}, title: "Title 1"})
      |> IO.inspect()

    assert todo_list
           |> TodoList.delete_entry(1) === %TodoList{auto_id: 2}
  end

  test "new from list" do
    todo_list =
      TodoList.new([
        %{date: {2020, 11, 13}, title: "Title 1"},
        %{date: {2020, 11, 13}, title: "Title X"},
        %{date: {2020, 9, 13}, title: "Title 2"},
        %{date: {2020, 2, 10}, title: "Title 3"}
      ])

    assert TodoList.entries(todo_list, {2020, 11, 13}) === [
             %{date: {2020, 11, 13}, title: "Title 1", id: 1},
             %{date: {2020, 11, 13}, id: 2, title: "Title X"}
           ]

    assert TodoList.entries(todo_list, {2020, 9, 13}) === [%{date: {2020, 9, 13}, title: "Title 2", id: 3}]
    assert TodoList.entries(todo_list, {2020, 2, 10}) === [%{date: {2020, 2, 10}, title: "Title 3", id: 4}]
  end
end

defmodule RefactoredTodoList.CsvImporterTest do
  use ExUnit.Case
  doctest RefactoredTodoList.CsvImporter

  alias RefactoredTodoList.CsvImporter, as: CsvImporter
  alias RefactoredTodoList, as: TodoList

  test "import a csv file in a RefactoredTodoList" do
    assert CsvImporter.import("test/resources/todo_list.csv") ===
             TodoList.new([
               %{date: {2013, 12, 19}, title: "Dentist", id: 1},
               %{date: {2013, 12, 20}, title: "Shopping", id: 2},
               %{date: {2013, 12, 19}, title: "Movies", id: 3}
             ])
  end
end
