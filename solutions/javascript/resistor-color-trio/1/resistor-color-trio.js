

export class ResistorColorTrio {

  static VALUES = {
    black: 0, brown: 1, red: 2, orange: 3, yellow: 4, green: 5, blue: 6, violet: 7,
    grey: 8, white: 9}

  static UNITS = ['ohms', 'kiloohms']
  
  constructor(bands) {

    const valueOf = function(color) {
      const value = ResistorColorTrio.VALUES[color]
      if (value === undefined) throw new Error('invalid color')
      return value
    }
    this._value = (10 * valueOf(bands[0]) + valueOf(bands[1])) * 10**valueOf(bands[2])
  }

  get label() {
    
    let value = this._value
    let unitIndex = 0
    while (value >= 1000) {
      value /= 1000
      unitIndex++
    }
    
    return `Resistor value: ${value} ${ResistorColorTrio.UNITS[unitIndex]}`
  }

}
