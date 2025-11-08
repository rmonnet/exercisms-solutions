
export class Series {

  constructor(series) {
    if (series.length == 0) throw new Error('series cannot be empty');
    this._series = series.split('').map(d => Number.parseInt(d));
  }

  slices(sliceLength) {

    if (sliceLength == 0) throw new Error('slice length cannot be zero');
    if (sliceLength < 0) throw new Error('slice length cannot be negative');
    if (sliceLength > this._series.length) throw new Error('slice length cannot be greater than series length');
    
    const result = [];
    for (let i = 0; i < this._series.length-sliceLength+1; i++) {
      result.push(this._series.slice(i, i+sliceLength));
    }
    return result;
  }
}
