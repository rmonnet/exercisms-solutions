var COLORS = ["black", "brown", "red", "orange", "yellow", "green",
  "blue", "violet", "grey", "white"]

class Resistor {
  static colorCode(color) {
    return COLORS.indexOf(color)
  }
}