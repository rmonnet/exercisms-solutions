defmodule PaintByNumber do
  def palette_bit_size(n) when n <= 2, do: 1

  def palette_bit_size(color_count) do
    1 + palette_bit_size(div(color_count + 1, 2))
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    pixel_size = palette_bit_size(color_count)
    <<pixel_color_index::size(pixel_size), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    pixel_size = palette_bit_size(color_count)
    <<first_pixel::size(^pixel_size), _::bitstring>> = picture
    first_pixel
  end

  def drop_first_pixel(<<>>, _), do: <<>>

  def drop_first_pixel(picture, color_count) do
    pixel_size = palette_bit_size(color_count)
    <<_::size(^pixel_size), rest_of_picture::bitstring>> = picture
    rest_of_picture
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
