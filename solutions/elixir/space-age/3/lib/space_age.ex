defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}

  def age_on(:earth, seconds), do: {:ok, seconds / 31557600}

  def age_on(:mercury, seconds) do
    {:ok, years_on_earth} = age_on(:earth, seconds)
    {:ok, years_on_earth / 0.2408467}
  end

  def age_on(:venus, seconds) do
    {:ok, years_on_earth} = age_on(:earth, seconds)
    {:ok, years_on_earth / 0.61519726}
  end

 def age_on(:mars, seconds) do
    {:ok, years_on_earth} = age_on(:earth, seconds)
    {:ok, years_on_earth / 1.8808158}
  end

  def age_on(:jupiter, seconds) do
    {:ok, years_on_earth} = age_on(:earth, seconds)
    {:ok, years_on_earth / 11.862615}
  end

  def age_on(:saturn, seconds) do
    {:ok, years_on_earth} = age_on(:earth, seconds)
    {:ok, years_on_earth / 29.447498}
  end

  def age_on(:uranus, seconds) do
    {:ok, years_on_earth} = age_on(:earth, seconds)
    {:ok, years_on_earth / 84.016846}
  end

  def age_on(:neptune, seconds) do
    {:ok, years_on_earth} = age_on(:earth, seconds)
    {:ok, years_on_earth / 164.79132}
  end

  def age_on(_, _), do: {:error, "not a planet"}
  
end
