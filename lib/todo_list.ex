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
