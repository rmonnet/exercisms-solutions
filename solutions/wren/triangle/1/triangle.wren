class Triangle {
  construct new(a, b, c) {
    _a = a
    _b = b
    _c = c
  }

  isEquilateral {
    return isTriangle && (_a == _b) && (_b == _c)
  }

  isIsosceles {
    return isTriangle && ((_a == _b) || (_a == _c) || (_b == _c))
  }

  isScalene {
    return isTriangle && ((_a != _b) && (_b != _c) && (_a != _c)) 
  }

  isTriangle {
    return (_a > 0) && (_b > 0) && (_c > 0) && (_a + _b >= _c) && (_a + _c >= _b) && (_b + _c >= _a)
  }
}
