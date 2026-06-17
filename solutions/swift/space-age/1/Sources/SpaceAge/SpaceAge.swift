class SpaceAge {
  let ageInSeconds: Double

  init(_ ageInSeconds: Int) {
    self.ageInSeconds = Double(ageInSeconds)
  }

  var onEarth: Double {
    ageInSeconds / SpaceAge.earthYearInSeconds
  }

  var onMercury: Double {
    ageInSeconds / (SpaceAge.earthYearInSeconds * SpaceAge.mercuryYear)
  }

  var onVenus: Double {
    ageInSeconds / (SpaceAge.earthYearInSeconds * SpaceAge.venusYear)
  }

  var onMars: Double {
    ageInSeconds / (SpaceAge.earthYearInSeconds * SpaceAge.marsYear)
  }

  var onJupiter: Double {
    ageInSeconds / (SpaceAge.earthYearInSeconds * SpaceAge.jupiterYear)
  }

  var onSaturn: Double {
    ageInSeconds / (SpaceAge.earthYearInSeconds * SpaceAge.saturnYear)
  }

  var onUranus: Double {
    ageInSeconds / (SpaceAge.earthYearInSeconds * SpaceAge.uranusYear)
  }

  var onNeptune: Double {
    ageInSeconds / (SpaceAge.earthYearInSeconds * SpaceAge.neptuneYear)
  }

  static let earthYearInSeconds: Double = 31_557_600
  static let mercuryYear: Double = 0.2408467
  static let venusYear: Double = 0.61519726
  static let marsYear: Double = 0.61519726
  static let jupiterYear: Double = 11.862615
  static let saturnYear: Double = 29.447498
  static let uranusYear: Double = 84.016846
  static let neptuneYear: Double = 164.79132
}
