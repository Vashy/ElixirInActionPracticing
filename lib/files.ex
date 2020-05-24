defmodule Files do
  def lines_lengths!(path) do
    path
    |> file_stream!
    |> Enum.map(&String.length/1)
  end

  def longest_line_length!(path) do
    path
    |> file_stream!
    |> Stream.map(&String.length/1)
    |> Enum.max()
  end

  def longest_line!(path) do
    path
    |> file_stream!
    |> Enum.sort(&(byte_size(&1) > byte_size(&2)))
    |> List.first()
  end

  def words_per_line!(path) do
    path
    |> file_stream!
    |> Enum.map(&length(String.split(&1)))
  end

  defp without_newline_character(str) do
    String.replace(str, "\n", "")
  end

  defp file_stream!(path) do
    path
    |> File.stream!()
    |> Stream.map(&without_newline_character/1)
  end
end
