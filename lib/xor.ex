defmodule Cryptopals.Xor do
  alias Cryptopals.Hex
  use Bitwise

  def hex_xor(str1, str2) do
    if String.length(str1) == String.length(str2) do
      bit_list_1 = Hex.to_bit_list(str1)
      bit_list_2 = Hex.to_bit_list(str2)

      Enum.zip(bit_list_1, bit_list_2)
      |> Enum.map(fn({bit1, bit2}) -> bit1 ^^^ bit2 end)
      |> Hex.from_bit_list
    else
      :error
    end
  end
end
