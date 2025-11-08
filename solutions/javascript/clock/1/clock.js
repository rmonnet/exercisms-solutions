
function pad(n, size) {
  let result = n.toFixed(0);
  if (result.length < size) {
    result = "0000000000".substring(0, size-result.length) + result;
  }
  return result;
}

export class Clock {

  static DAY_IN_MINUTES = 24 * 60;

  constructor(hours=0, minutes=0) {
    
    let timeInMinutes = (hours * 60) + minutes;
    // normalize the time between 0 hours and 24 hours
    timeInMinutes = timeInMinutes % Clock.DAY_IN_MINUTES;   
    if (timeInMinutes < 0) timeInMinutes += Clock.DAY_IN_MINUTES;
    this._timeInMinutes = timeInMinutes;
  }

  toString() {
    let hours = Math.trunc(this._timeInMinutes / 60);
    let minutes = this._timeInMinutes - hours * 60;
    return `${pad(hours, 2)}:${pad(minutes, 2)}`;
  }

  plus(minutes) {
    return new Clock(0, this._timeInMinutes + minutes);
  }

  minus(minutes) {
    return new Clock(0, this._timeInMinutes - minutes);
  }

  equals(other) {
    return this._timeInMinutes === other._timeInMinutes;
  }
}
