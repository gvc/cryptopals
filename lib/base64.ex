defmodule Cryptopals.Base64 do
  @code to_char_list("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/")

  def encode_hex(hex_string) do
    hex_string
    |> hex_to_bit_list
    |> encode_bit_list
  end

  def encode(string) do
    ascii_bit_list =
      string
      |> ascii_to_bit_list

    {padded_bit_list, pad_count} = pad_bit_list(ascii_bit_list)

    encoded =
      padded_bit_list
      |> encode_bit_list

    case pad_count do
      0 -> encoded
      1 -> String.slice(encoded, 0..-2) <> "="
      2 -> String.slice(encoded, 0..-3) <> "=="
    end
  end

  defp pad_bit_list(bit_list) when rem(length(bit_list), 24) == 0 do
    {bit_list, 0}
  end

  defp pad_bit_list(bit_list) when rem(length(bit_list), 24) == 16 do
    {bit_list ++ [0,0,0,0,0,0,0,0], 1}
  end

  defp pad_bit_list(bit_list) when rem(length(bit_list), 24) == 8 do
    {bit_list ++ [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], 2}
  end

  defp encode_bit_list(bit_list) do
    number_list =
      bit_list
      |> Enum.chunk(6, 6)
      |> Enum.map(fn(bit_array) ->
        {number, _} = Integer.parse(Enum.join(bit_array), 2)
        number
      end)

    base64 = Enum.map(number_list, fn(index) ->
      Enum.at(@code, index)
    end)

    to_string(base64)
  end

  defp hex_to_bit_list(hex_string) do
    hex_string
    |> String.graphemes
    |> Enum.flat_map(fn(codepoint) ->
      {n, _} = Integer.parse(codepoint, 16)
      Enum.take([0,0,0,0] ++ Integer.digits(n, 2), -4)
    end)
  end

  defp ascii_to_bit_list(str) do
    str
    |> to_char_list
    |> Enum.flat_map(fn(x) ->
      Enum.take([0,0,0,0,0,0,0,0] ++ Integer.digits(x, 2), -8)
    end)
  end
end
