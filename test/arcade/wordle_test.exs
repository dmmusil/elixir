defmodule Arcade.WordleTest do
  use ExUnit.Case

  alias Arcade.Wordle

  describe "evaluating guesses" do
    test "all absent when totally wrong" do
      word = "abcde"
      guess = "fghij"

      assert Enum.all?(Wordle.evaluate_guess(word, guess), fn c -> c == :absent end)
    end

    test "all correct when word is guessed" do
      word = "abcde"
      guess = "abcde"

      assert Enum.all?(Wordle.evaluate_guess(word, guess), fn c -> c == :correct end)
    end

    test "handles duplicate letters in guesses, single occurrence in word" do
      word = "abcde"
      guess = "aaaaa"

      assert Wordle.evaluate_guess(word, guess) == [:correct, :absent, :absent, :absent, :absent]
    end

    test "handles duplicate letters in guesses, multiple occurrences in word" do
      word = "abcda"
      guess = "aaaab"

      assert Wordle.evaluate_guess(word, guess) == [
               :correct,
               :present,
               :absent,
               :absent,
               :present
             ]
    end

    test "handles duplicate letters in guesses, multiple occurrences in word v2" do
      word = "tests"
      guess = "ttttt"

      assert Wordle.evaluate_guess(word, guess) == [
               :correct,
               :absent,
               :absent,
               :correct,
               :absent
             ]
    end
  end
end
