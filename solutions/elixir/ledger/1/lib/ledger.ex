defmodule Ledger do
  # Refactoring:
  # 1. Split header in its own function.
  # 2. Provide a cluase for header for the en_US locale
  # 3. Create a function clause for format_entries when there is no entry.
  # 4. Move sort comparison into its own function (less_than()).
  # 5. split the format_date() function.
  # 6. Provide a clause for format_date for the :en_US locale.
  # 7. Provide a function to split an amount in units and 'cents'.
  # 8. Clean-up format_entry using string extrapolation.
  # 9. Split format_decimal() and format_delim.
  # 10. Add separate clause for format_amount for en_US locale.

  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  defp header(:en_US), do: "Date       | Description               | Change       \n"
  defp header(_), do: "Datum      | Omschrijving              | Verandering  \n"

  @doc """
  Format the given entries given a currency and locale
  """
  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(_, locale, []), do: header(locale)

  def format_entries(currency, locale, entries) do
    entries =
      Enum.sort(entries, &less_than(&1, &2))
      |> Enum.map(&format_entry(currency, locale, &1))
      |> Enum.join("\n")

    header(locale) <> entries <> "\n"
  end

  defp less_than(a, b) do
    cond do
      a.date.day < b.date.day -> true
      a.date.day > b.date.day -> false
      a.description < b.description -> true
      a.description > b.description -> false
      true -> a.amount_in_cents <= b.amount_in_cents
    end
  end

  defp format_date(date, :en_US), do: Calendar.strftime(date, "%m/%d/%Y ")
  defp format_date(date, _), do: Calendar.strftime(date, "%d-%m-%Y ")

  defp split_amount(amount_in_cents) do
    amount_in_cents = abs(amount_in_cents)
    {div(amount_in_cents, 100), rem(amount_in_cents, 100)}
  end

  defp format_decimal(amount_decimal), do: "#{amount_decimal}" |> String.pad_leading(2, "0")

  defp format_whole(amount_whole, delim) do
    if amount_whole < 1000 do
      "#{amount_whole}"
    else
      "#{div(amount_whole, 1000)}#{delim}#{rem(amount_whole, 1000)}"
    end
  end

  def format_amount(currency, :en_US, amount_in_cents) do
    {amount_whole, amount_decimal} = split_amount(amount_in_cents)
    number = "#{format_whole(amount_whole, ",")}.#{format_decimal(amount_decimal)}"

    if amount_in_cents >= 0 do
      "  #{symbol(currency)}#{number} "
    else
      " (#{symbol(currency)}#{number})"
    end
  end

  def format_amount(currency, _, amount_in_cents) do
    {amount_whole, amount_decimal} = split_amount(amount_in_cents)
    number = "#{format_whole(amount_whole, ".")},#{format_decimal(amount_decimal)}"

    if amount_in_cents >= 0 do
      " #{symbol(currency)} #{number} "
    else
      " #{symbol(currency)} -#{number} "
    end
  end

  defp symbol(:eur), do: "€"
  defp symbol(_), do: "$"

  defp format_entry(currency, locale, entry) do
    date = format_date(entry.date, locale)

    amount =
      format_amount(currency, locale, entry.amount_in_cents)
      |> String.pad_leading(14, " ")

    description =
      if String.length(entry.description) > 26 do
        " #{String.slice(entry.description, 0, 22)}..."
      else
        " #{String.pad_trailing(entry.description, 25, " ")}"
      end

    "#{date}|#{description} |#{amount}"
  end
end
