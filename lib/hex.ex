defmodule Cryptopals.Hex do

  def to_bit_list(hex_string) do
    hex_string
    |> String.graphemes
    |> Enum.flat_map(fn(codepoint) ->
      {n, _} = Integer.parse(codepoint, 16)
      Enum.take([0,0,0,0] ++ Integer.digits(n, 2), -4)
    end)
  end

  def from_bit_list(bit_list) do
    bit_list
    |> Enum.chunk(4, 4)
    |> Enum.map(fn(chunk) ->
      {number, _} = Integer.parse(Enum.join(chunk), 2)
      Integer.to_char_list(number, 16)
    end)
    |> to_string
    |> String.downcase
  end
end
