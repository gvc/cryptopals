defmodule Cryptopals.XorTest do
  use ExUnit.Case
  doctest Cryptopals.Xor

  test "it calculates the XOR of two hex strings" do
    assert Cryptopals.Xor.hex_xor(
      "1c0111001f010100061a024b53535009181c",
      "686974207468652062756c6c277320657965") ==
    "746865206b696420646f6e277420706c6179"
  end

  test "ir returns an error if sizes don't match" do
    assert Cryptopals.Xor.hex_xor("1c01", "68") == :error
  end
end
