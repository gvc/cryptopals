defmodule Cryptopals.XorCipherDetector do
  alias Cryptopals.XorCipher

  def detect_in_file(filepath) do
    case File.read(filepath) do
      {:ok, body} ->
        {deciphered_string, score} =
          body
          |> String.split
          |> Enum.map(fn(ciphered_string) ->
            Task.async(fn -> XorCipher.decrypt(ciphered_string) end)
          end)
          |> Enum.map(fn(task) ->
            Task.await(task, 60000)
          end)
          |> Enum.sort_by(fn({_alternative, score}) -> score end)
          |> Enum.reverse
          |> Enum.at(0)
        IO.puts(deciphered_string)
      {:error, reason} ->
        IO.puts(reason)
    end
  end
end
