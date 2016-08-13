defmodule Cryptopals.Base64Test do
  use ExUnit.Case
  doctest Cryptopals.Base64

  test "it encodes a hex string in base64" do
    assert Cryptopals.Base64.encode_hex("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d") ==
      "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
  end

  test "it encodes a 'man' as 'TWFu'" do
    assert Cryptopals.Base64.encode("Man") == "TWFu"
  end

  test "it encodes 'M' as TQ==" do
    assert Cryptopals.Base64.encode("M") == "TQ=="
  end

  test "it encodes 'Ma' as 'TWE='" do
    assert Cryptopals.Base64.encode("Ma") == "TWE="
  end
end
