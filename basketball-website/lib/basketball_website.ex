defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    do_extract(data, String.split(path, "."))
  end

  defp do_extract(data, path)
  defp do_extract(data, []), do: data
  defp do_extract(data, [head | tail]), do: do_extract(data[head], tail)

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
