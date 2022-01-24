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
    |> Enum.reduce({[], letter_count}, fn {c, i}, acc ->
      cond do
        String.at(word, i) == c ->
          {elem(acc, 0) ++ [:correct], decrement_letter(c, elem(acc, 1))}

        String.contains?(word, c) && at_least_one(c, elem(acc, 1)) ->
          {elem(acc, 0) ++ [:present], decrement_letter(c, elem(acc, 1))}

        true ->
          {elem(acc, 0) ++ [:absent], elem(acc, 1)}
      end
    end)
    |> elem(0)
  end

  defp decrement_letter(letter, counts) do
    Map.update(counts, letter, 0, fn l -> max(0, l - 1) end)
  end

  defp at_least_one(letter, counts) do
    Map.get(counts, letter, 0) > 0
  end
end
