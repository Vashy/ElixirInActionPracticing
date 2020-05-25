defmodule TodoList do
  def new, do: %{}

  def add_entry(todo_list, entry) do
    MultiMap.put(todo_list, entry.date, entry.title)
  end

  def entries(todo_list, date) do
    MultiMap.get(todo_list, date)
  end
end

defmodule MultiMap do
  def new, do: %{}

  def put(map, key, value) do
    Map.update(map, key, [value], &[value | &1])
  end

  def get(map, key), do: Map.get(map, key)
end

defmodule RefactoredTodoList do
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %RefactoredTodoList{},
      fn entry, todo_list_acc -> add_entry(todo_list_acc, entry) end
    )
  end

  def add_entry(
        %RefactoredTodoList{entries: entries, auto_id: auto_id} = todo_list,
        entry
      ) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = Map.put(entries, auto_id, entry)

    %RefactoredTodoList{todo_list | entries: new_entries, auto_id: auto_id + 1}
  end

  def entries(%RefactoredTodoList{entries: entries}, date) do
    entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_entry(
        %RefactoredTodoList{entries: entries} = todo_list,
        entry_id,
        updater_fun
      ) do
    case entries[entry_id] do
      nil ->
        todo_list

      old_entry ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = Map.put(entries, new_entry.id, new_entry)
        %RefactoredTodoList{todo_list | entries: new_entries}
    end
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  def delete_entry(%RefactoredTodoList{entries: entries} = todo_list, id) do
    new_entries = Map.delete(entries, id)
    %RefactoredTodoList{todo_list | entries: new_entries}
  end

  defmodule CsvImporter do

    def import(path) do
      path
      |> File.stream!()
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Stream.map(&String.split(&1, ","))
      |> Stream.map(&List.to_tuple(&1))
      |> Stream.map(&%{date: to_date(elem(&1, 0)), title: elem(&1, 1)})
      |> RefactoredTodoList.new()
    end

    defp to_date(datestr) do
      date =
        datestr
        |> String.split("/")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()

      {elem(date, 0), elem(date, 1), elem(date, 2)}
    end
  end
end
