defmodule Cryptopals.Hex do

  def to_ascii(hex_string) do
    hex_string
    |> to_bit_list
    |> Enum.chunk(8, 8)
    |> Enum.map(&Cryptopals.BitRepresentation.to_ascii/1)
    |> to_string
  end

  def to_bit_list(hex_string) do
    hex_string
    |> String.graphemes
    |> Enum.flat_map(&Cryptopals.BitRepresentation.from_hex/1)
  end

  def from_bit_list(bit_list) do
    bit_list
    |> Enum.chunk(4, 4)
    |> Enum.map(&Cryptopals.BitRepresentation.to_hex/1)
    |> to_string
    |> String.downcase
  end
end
