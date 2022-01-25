defmodule Arcade.Wordle do
  def evaluate_guess(word, guess) do
    letter_count = letter_count(word)

    initial_state =
      {%{"0" => :absent, "1" => :absent, "2" => :absent, "3" => :absent, "4" => :absent},
       letter_count}

    correct_result =
      guess
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce(
        initial_state,
        fn {c, i}, acc ->
          {result, counts} = acc

          cond do
            String.at(word, i) == c ->
              {Map.put(result, to_string(i), :correct), decrement_letter(counts, c)}

            true ->
              acc
          end
        end
      )

    final_result =
      guess
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce(
        correct_result,
        fn {c, i}, acc ->
          {result, counts} = acc

          cond do
            Map.get(result, to_string(i)) == :correct ->
              acc

            String.contains?(word, c) && at_least_one(counts, c) ->
              {Map.put(result, to_string(i), :present), decrement_letter(counts, c)}

            true ->
              acc
          end
        end
      )

    final_result
    |> elem(0)
    |> Map.values()
  end

  defp decrement_letter(counts, letter) do
    Map.update(counts, letter, 0, fn l -> max(0, l - 1) end)
  end

  defp at_least_one(counts, letter) do
    Map.get(counts, letter, 0) > 0
  end

  defp letter_count(word) do
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
  end
end
