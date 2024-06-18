defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    min_bit_size(color_count, 1)
  end

  defp min_bit_size(max_val, count) do
    if Integer.pow(2, count) < max_val do
      min_bit_size(max_val, count+1)
    else
      count
    end
  end

  def empty_picture(), do: << >>

  def test_picture(), do: << 0b00011011 >>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    palette_size = palette_bit_size(color_count)
    << pixel_color_index::size(palette_size), picture::bitstring >>
  end

  def get_first_pixel(picture, color_count)
  def get_first_pixel(<< >>, _), do: nil
  def get_first_pixel(picture, color_count) do
    palette_size = palette_bit_size(color_count)
    << first::size(palette_size), _::bitstring >> = picture

    first
  end

  def drop_first_pixel(picture, color_count)
  def drop_first_pixel(<<>>, _), do: <<>>
  def drop_first_pixel(picture, color_count) do
    palette_size = palette_bit_size(color_count)
    <<_::size(palette_size), rest::bitstring>> = picture

    rest
  end

  def concat_pictures(picture1, picture2), do: <<picture1::bitstring, picture2::bitstring>>
end
