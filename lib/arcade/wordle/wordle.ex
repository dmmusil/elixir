defmodule Arcade.Wordle do
  def evaluate_guess(word, guess) do
    letter_count =
      word
      |> String.codepoints()
      |> Enum.reduce(%{}, fn char, map ->
        Map.update(map, char, 1, fn v ->
          cond do
            is_nil(v) -> 1
            true -> v + 1
          end
        end)
      end)

    guess
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.map(fn {c, i} ->
      cond do
        String.at(word, i) == c -> :correct
        String.contains?(word, c) -> :present
        true -> :absent
      end
    end)
  end
end
