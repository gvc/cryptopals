defmodule Cryptopals.BitRepresentation do

  def from_hex(hex_digit) when is_binary(hex_digit) do
    {number, _} = Integer.parse(hex_digit, 16)

    Enum.take([0,0,0,0] ++ Integer.digits(number, 2), -4)
  end

  def from_hex(hex_digit) when is_list(hex_digit) do
    hex_digit
    |> to_string
    |> from_hex
  end

  def to_hex(bit_list) do
    {number, _} = Integer.parse(Enum.join(bit_list), 2)

    Integer.to_char_list(number, 16)
    |> to_string
    |> String.downcase
    |> to_char_list
  end

  def from_ascii(char) when is_list(char) do
    [number | _tail] = char ++ 0

    Enum.take([0,0,0,0,0,0,0,0] ++ Integer.digits(number, 2), -8)
  end

  def from_ascii(char) when is_binary(char) do
    char
    |> to_char_list
    |> from_ascii
  end

  def to_ascii(bit_list) do
    {number, _} = Integer.parse(Enum.join(bit_list), 2)

    [number]
  end
end
