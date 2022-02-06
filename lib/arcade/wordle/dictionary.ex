defmodule Arcade.Wordle.Dictionary do
  @all_guesses Application.app_dir(:arcade, "priv/wordle/valid.txt")
               |> File.read!()
               |> String.split("\n", trim: true)

  @all_answers Application.app_dir(:arcade, "priv/wordle/answers.txt")
               |> File.read!()
               |> String.split("\n", trim: true)

  def answers() do
    @all_answers
  end

  def valid_guesses() do
    @all_guesses
  end

  def all_words() do
    answers() ++ valid_guesses()
  end

  def random() do
    answers = answers()
    length = Enum.count(answers)
    answers |> Enum.at(Enum.random(0..length))
  end

  def valid_guess?(guess) do
    all_words() |> Enum.any?(&(&1 == guess))
  end
end
