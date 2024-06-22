defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc)
  def decode_secret_message_part({key, _, args} = ast, acc) when key in [:def, :defp] do
    {name, args} = get_function_definition(args)
    arity = length(args)
    name = name |> to_string() |> String.slice(0, arity)
    {ast, [name | acc]}
  end
  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp get_function_definition(definition) do
    case definition do
      [{:when, _, func}|_] -> get_function_definition(func)
      [{name, _, nil}|_] -> {name, []}
      [{name, _, args}|_] -> {name, args}
    end
  end

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end
