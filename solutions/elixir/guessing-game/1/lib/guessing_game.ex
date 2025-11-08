defmodule GuessingGame do
  def compare(secret, secret), do: "Correct"
  def compare(_, guess \\ :no_guess) when guess == :no_guess, do: "Make a guess"
  def compare(secret, guess) when abs(guess - secret) == 1, do: "So close"
  def compare(secret, guess) when guess > secret, do: "Too high"
  def compare(secret, guess) when guess < secret, do: "Too low"
end
