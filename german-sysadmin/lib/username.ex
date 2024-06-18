defmodule Username do
  def sanitize([]), do: []

  def sanitize(username) do

    [head | tail] = username

    tail = sanitize(tail)

    is_letter? = head >= ?a && head <= ?z
    is_underscore? = head == ?_

    case head do
      head when is_letter? -> [head]
      head when is_underscore? -> [head]
      ?_ -> [head]
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> []
    end ++ tail
  end
end
