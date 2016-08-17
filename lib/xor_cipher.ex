defmodule Cryptopals.XorCipher do
  alias Cryptopals.Xor
  alias Cryptopals.Hex

  # @hex_chars to_char_list("01234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-=!@#$")
  @chars 0..255

  def decrypt(hex_string) do
    @chars
    |> Enum.map(fn(char) -> decrypt_against(hex_string, char) end)
    |> Enum.map(fn(hex) -> Hex.to_ascii(hex) end)
    |> score_alternatives([])
    |> Enum.sort_by(fn({_alternative, score}) -> score end)
    |> Enum.map(fn({alternative, _score}) -> alternative end)
    |> Enum.reverse
    |> Enum.at(0)
  end

  defp decrypt_against(hex_string, char) do
    # Tenho que gerar uma string com o mesmo número de bits que a hex_string
    char_string =
      hex_string
      |> String.graphemes
      |> Enum.flat_map(fn(_grapheme) -> Cryptopals.BitRepresentation.from_ascii([char]) end)
      |> Enum.chunk(4, 4)
      |> Enum.flat_map(&Cryptopals.BitRepresentation.to_hex/1)
      |> to_string

    Xor.hex_xor(hex_string, String.slice(char_string, 0, String.length(hex_string)))
  end

  defp score_alternatives([alternative | tail], acc) do
    alternative_tuple = {alternative, score_alternative(alternative)}

    score_alternatives(tail, [alternative_tuple | acc])
  end

  defp score_alternatives([], acc) do
    acc
  end

  defp score_alternative(alternative) do
    ordered_letters = String.graphemes("etaoinshrdlucmfwypvb")
    alternative
    |> String.downcase
    |> String.graphemes
    |> Enum.reduce(0, fn(x, acc) ->
      index = Enum.find_index(ordered_letters, fn(l) ->
        x == l
      end) || 26

      acc + (26 - index)
    end)
  end
end
