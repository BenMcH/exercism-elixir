defmodule LogParser do
  def valid_line?(line) do
    String.match?(line, ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/)
  end

  def split_line(line) do
    String.split(line, ~r/<[~*=-]*>/)
  end

  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line\d+/i, line, "")
  end

  def tag_with_user_name(line) do
    user_regex = ~r/User\s+([^\s]+)/
    if line =~ user_regex do
      [_, name | _] = Regex.run(user_regex, line)
      "[USER] #{name} #{line}"
    else
      line
    end
  end
end
