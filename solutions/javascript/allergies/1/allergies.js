

export class Allergies {

  static PRODUCTS = ['eggs', 'peanuts', 'shellfish', 'strawberries',
    'tomatoes', 'chocolate', 'pollen', 'cats'];
  
  constructor(score) {
    // each specific allergy is a multiple of 2, converting the score to a binary number
    // and reversing so that the lowest digit is first in the list (eggs).
    this._allergyTests = score.toString(2).split('').reverse();
  }

  list() {
    const allergies = [];
    for (let i = 0; i < this._allergyTests.length && i < Allergies.PRODUCTS.length; i++) {
      if (this._allergyTests[i] == '1') allergies.push(Allergies.PRODUCTS[i]);
    }
    return allergies;
  }

  allergicTo(product) {
    const idx = Allergies.PRODUCTS.indexOf(product);
    if (idx == -1) return false;
    return this._allergyTests[idx] == '1';
  }
}
