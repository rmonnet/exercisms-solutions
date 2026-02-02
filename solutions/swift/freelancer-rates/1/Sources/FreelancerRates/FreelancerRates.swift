func dailyRateFrom(hourlyRate: Int) -> Double {
  
  let workHoursPerDay: Double = 8
  return workHoursPerDay *  Double(hourlyRate)
}

func monthlyRateFrom(hourlyRate: Int, withDiscount discount: Double) -> Double {
  
  let workDaysPerMonth: Double = 22
  let plainMonthlyRate = dailyRateFrom(hourlyRate: hourlyRate) * workDaysPerMonth
  return plainMonthlyRate * (100.0 - discount) / 100.0
}

func workdaysIn(budget: Double, hourlyRate: Int, withDiscount discount: Double) -> Double {

  let dailyRateWithDiscount =
      dailyRateFrom(hourlyRate: hourlyRate) * (100.0 - discount) / 100.0
  let daysBudget = budget / dailyRateWithDiscount
  return daysBudget.rounded(.down)
}
