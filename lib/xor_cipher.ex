defmodule Cryptopals.XorCipher do
  alias Cryptopals.Xor
  alias Cryptopals.Hex
  alias Cryptopals.BitRepresentation

  @chars 0..255

  def decrypt(hex_string) do
    @chars
    |> Enum.map(fn(char) -> decrypt_against(hex_string, char) end)
    |> Enum.map(&Hex.to_ascii/1)
    |> score_alternatives([])
    |> Enum.sort_by(fn({_alternative, score}) -> score end)
    |> Enum.reverse
    |> Enum.at(0)
  end

  defp decrypt_against(hex_string, char) do
    char_string =
      hex_string
      |> String.graphemes
      |> Enum.flat_map(fn(_grapheme) -> BitRepresentation.from_ascii([char]) end)
      |> Enum.chunk(4, 4)
      |> Enum.flat_map(&BitRepresentation.to_hex/1)
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
    scores = %{
      "e" => 26, "t" => 25, "a" => 24, "o" => 23, "i" => 22, "n" => 21, "s" => 20,
      "h" => 19, "r" => 18, "d" => 17, "l" => 16, "u" => 15, "c" => 14, "m" => 13,
      "f" => 12, "w" => 11, "y" => 10, "p" => 9, "v" => 8, "b" => 7, "g" => 6,
      "k" => 5, "j" => 4, "q" => 3, "x" => 2, "z" => 1
    }

    alternative
    |> String.downcase
    |> String.graphemes
    |> Enum.reduce(0, fn(x, acc) ->
      acc + (Map.get(scores, x) || 0)
    end)
  end
end
