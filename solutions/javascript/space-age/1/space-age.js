const SECONDS_PER_EARTH_YEAR = 31557600;

const PLANET_EARTH_RATIO = {
    'mercury': 0.2408467,
    'venus': 0.61519726,
    'earth': 1.0,
    'mars': 1.8808158,
    'jupiter': 11.862615,
    'saturn': 29.447498,
    'uranus': 84.016846,
    'neptune': 164.79132,
};

// Truncates a number to the given number of digits
function truncate(n, digits) {
  return Number(n.toFixed(digits));
}
export function age(planet, ageInSeconds) {
  const ageOnPlanet = ageInSeconds / (SECONDS_PER_EARTH_YEAR * PLANET_EARTH_RATIO[planet]);
  return truncate(ageOnPlanet, 2);
};
