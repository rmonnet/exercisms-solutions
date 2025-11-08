defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add(a={n1,d1}, b={n2,d2}),  do: reduce({n1*d2+n2*d1, d1*d2})

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a={n1,d1}, b={n2,d2}),  do: reduce({n1*d2-n2*d1, d1*d2})

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply(a={n1,d1}, b={n2,d2}), do: reduce({n1*n2, d1*d2})

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num={n1,d1}, den={n2,d2}), do: reduce({n1*d2, n2*d1})

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs(a={n,d}), do: reduce({Kernel.abs(n), Kernel.abs(d)})

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(a={num,den}, n) when n >= 0, do: reduce({num**n, den**n})
  def pow_rational(a={num,den}, n) when n < 0, do: reduce({den**(-n), num**(-n)})

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n={num,den}), do: x**(num/den)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a={n,d}) do
    gcd = Integer.gcd(n,d)
    redN = div(n, gcd)
    redD = div(d, gcd)
    if redD < 0 do
      {-redN,-redD}
    else
      {redN,redD}
    end
  end
end
