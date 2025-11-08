defmodule RomanNumerals do

  # Romans didn't know 0 but having it in the translation map avoid special cases
  @romans %{0 => "", 1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V", 6 => "VI",
    7 => "VII", 8 => "VIII", 9 => "IX", 10 => "X", 20 => "XX", 30 => "XXX", 40 => "XL",
    50 => "L", 60 => "LX", 70 => "LXX", 80 => "LXXX", 90 => "XC", 100 => "C", 200 => "CC",
    300 => "CCC", 400 => "CD", 500 => "D", 600 => "DC", 700 => "DCC", 800 => "DCCC",
    900 => "CM", 1000 => "M", 2000 => "MM", 3000 => "MMM"}

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    remaining = number
    translation = ""
    # populate the thousands
    thousands = div(remaining, 1000)
    translation = translation <> Map.get(@romans, 1000 * thousands, "?")
    remaining = remaining - 1000 * thousands
    # populate the hundreds
    hundreds = div(remaining, 100)
    translation = translation <> Map.get(@romans, 100 * hundreds, "?")
    remaining = remaining - 100 * hundreds
    # populate the tens
    tens = div(remaining, 10)
    translation = translation <> Map.get(@romans, 10 * tens, "?")
    remaining = remaining - 10 * tens
    # populate the digits
    translation = translation <> Map.get(@romans, remaining, "?")
  end
end
