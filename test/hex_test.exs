defmodule Cryptopals.HexTest do
  use ExUnit.Case

  doctest Cryptopals.Hex

  test "it decodes '48656c6c6f' to 'Hello'" do
    assert Cryptopals.Hex.to_ascii("48656c6c6f") == "Hello"
  end
end
