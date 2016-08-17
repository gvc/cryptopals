defmodule Cryptopals.BitRepresentationTest do
  use ExUnit.Case
  alias Cryptopals.BitRepresentation

  doctest Cryptopals.BitRepresentation

  test "it represents ASCII 'c' as '01100011'" do
    assert BitRepresentation.from_ascii('c') == [0,1,1,0,0,0,1,1]
  end

  test "it converts 01100011 back to ASCII 'c'" do
    assert BitRepresentation.to_ascii([0,1,1,0,0,0,1,1]) == 'c'
  end

  test "it represents HEX 'c' as '1100'" do
    assert BitRepresentation.from_hex('c') == [1,1,0,0]
  end

  test "it converts 1100 back to HEX 'c'" do
    assert BitRepresentation.to_hex([1,1,0,0]) == 'c'
  end
end
