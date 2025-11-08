defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a_num,a_denum}, {b_num,b_denum})  do
    reduce({a_num*b_denum+b_num*a_denum, a_denum*b_denum})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a_num,a_denum}, {b_num,b_denum}) do
    reduce({a_num*b_denum-b_num*a_denum, a_denum*b_denum})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a_num,a_denum}, {b_num,b_denum}) do
    reduce({a_num*b_num, a_denum*b_denum})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(a :: rational, b :: rational) :: rational
  def divide_by({a_num,a_denum}, {b_num,b_denum}) do
    reduce({a_num*b_denum, b_num*a_denum})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a_num,a_denum}) do
    reduce({Kernel.abs(a_num), Kernel.abs(a_denum)})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a_num,a_denum}, n) do
    cond do
      n >= 0 -> reduce({a_num**n, a_denum**n})
      n < 0 -> reduce({a_denum**(-n), a_num**(-n)})
    end
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {num,denum}), do: x**(num/denum)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a_num,a_denum}) do
    gcd = Integer.gcd(a_num,a_denum)
    red_num = div(a_num, gcd)
    red_denum = div(a_denum, gcd)
    if red_denum < 0 do
      {-red_num,-red_denum}
    else
      {red_num,red_denum}
    end
  end
end
