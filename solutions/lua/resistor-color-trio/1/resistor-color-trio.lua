local VALUES = {
  black = 0,
  brown = 1,
  red = 2,
  orange = 3,
  yellow = 4,
  green = 5,
  blue = 6,
  violet = 7,
  grey = 8,
  white = 9,
}

local UNITS = {
  "kilo"
}


return {
  decode = function(c1, c2, c3)

    local value = (10 * VALUES[c1] + VALUES[c2]) * 10 ^ VALUES[c3]
    local unit = "ohms"
    if value >= 1000 then
      value = value / 1000
      unit = 'kiloohms'
    end
    return value, unit
  end
}
