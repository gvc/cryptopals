defmodule Cryptopals.XorCipherTest do
  use ExUnit.Case

  doctest Cryptopals.XorCipher

  test "it decodes '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'" do
    assert Cryptopals.XorCipher.decrypt("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736") == "Cooking MC's like a pound of bacon"
  end
end

