defmodule FilesTest do
  use ExUnit.Case
  doctest Files

  test "longest line length" do
    assert Files.longest_line_length!("test/resources/some_file.txt") == 16
  end

  test "lines lenghts" do
    assert Files.lines_lengths!("test/resources/some_file.txt") == [4, 10, 16, 0, 5]
  end

  test "longest line content" do
    assert Files.longest_line!("test/resources/some_file.txt") == "some other words"
  end

  test "words per line" do
    assert Files.words_per_line!("test/resources/some_file.txt") == [1, 2, 3, 0, 1]
  end
end
