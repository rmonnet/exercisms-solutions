defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @spec sign(a :: integer) :: integer
  defp sign(a) when a < 0, do: -1
  defp sign(_), do: 1

  @spec gcd(a :: integer, b :: integer) :: integer
  defp gcd(a, 0), do: a
  defp gcd(a, b) when a < b, do: gcd(b, a)
  defp gcd(a, b), do: gcd(b, rem(a, b))

  @spec reduce(a :: integer, b :: integer) :: rational
  defp reduce(a, b) do
    abs_a = Kernel.abs(a)
    abs_b = Kernel.abs(b)
    s = sign(a * b)
    denom = gcd(abs_a, abs_b)
    {s * div(abs_a, denom), div(abs_b, denom)}
  end

  @doc """
  Add two rational numbers
  """
  @spec add(r1 :: rational, r2 :: rational) :: rational
  def add(r1, r2) do
    {a1, b1} = r1
    {a2, b2} = r2
    reduce(a1 * b2 + a2 * b1, b1 * b2)
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(r1 :: rational, r2 :: rational) :: rational
  def subtract(r1, r2) do
    {a1, b1} = r1
    {a2, b2} = r2
    reduce(a1 * b2 - a2 * b1, b1 * b2)
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(r1 :: rational, r2 :: rational) :: rational
  def multiply(r1, r2) do
    {a1, b1} = r1
    {a2, b2} = r2
    reduce(a1 * a2, b1 * b2)
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(r1 :: rational, r2 :: rational) :: rational
  def divide_by(r1, r2) do
    {a1, b1} = r1
    {a2, b2} = r2
    reduce(a1 * b2, a2 * b1)
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(r :: rational) :: rational
  def abs(r) do
    {a, b} = r
    reduce(Kernel.abs(a), Kernel.abs(b))
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(r :: rational, n :: integer) :: rational
  def pow_rational(r, n) when n < 0 do
    {a, b} = r
    reduce(b ** -n, a ** -n)
  end

  def pow_rational(r, n) do
    {a, b} = r
    reduce(a ** n, b ** n)
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
    {a, b} = n
    x ** a ** (1 / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(r :: rational) :: rational
  def reduce(r) do
    {a, b} = r
    reduce(a, b)
  end
end
