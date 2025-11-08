const _periods = {
  'Mercury': 0.2408467,
  'Venus': 0.61519726,
  'Earth': 1.0,
  'Mars': 1.8808158,
  'Jupiter': 11.862615,
  'Saturn': 29.447498,
  'Uranus': 84.016846,
  'Neptune': 164.79132,
};

const _secondsInYear = 31557600;

class SpaceAge {
  num age({String planet = '', num seconds = 0}) {
    var planetSeconds = seconds / (_periods[planet] ?? 0);
    var ageInCentiYears = planetSeconds / _secondsInYear * 100;
    return ageInCentiYears.roundToDouble() / 100;
  }
}
