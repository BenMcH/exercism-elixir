defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end
  end

  def type_from_binary(file_binary)
  def type_from_binary(<< 0x7f, 0x45, 0x4c, 0x46, _::binary>>), do: type_from_extension("exe")
  def type_from_binary(<< 0x42, 0x4d, _::binary>>), do: type_from_extension("bmp")
  def type_from_binary(<< 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>), do: type_from_extension("png")
  def type_from_binary(<< 0xFF, 0xD8, 0xFF, _::binary>>), do: type_from_extension("jpg")
  def type_from_binary(<< 0x47, 0x49, 0x46, _::binary>>), do: type_from_extension("gif")
  def type_from_binary(_), do: nil

  def verify(file_binary, extension) do
    file_binary = type_from_binary(file_binary)
    extension = type_from_extension(extension)

    if file_binary !== nil and file_binary === extension do
      {:ok, file_binary}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
