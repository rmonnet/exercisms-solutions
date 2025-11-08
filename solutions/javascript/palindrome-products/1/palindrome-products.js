export class Palindromes {

  // Checks if the number is a palindrome.
  static isPalindrome(n) {
    
    // There is two methods, either convert to a string and compare to the reversed string
    // or build the numerical "reverse" number with the digits reversed.
    // The second method (used here) is faster in javascript.
      let reverse = 0
      let number = n
        while (number > 0) {
          const digit = number % 10
          reverse = reverse * 10 + digit
          number = Math.trunc(number / 10)
        }
      return reverse == n
    }
  
  // Generates the palindromes from the products of two numbers
  // between minFactor and maxFactor.
  static generate({minFactor, maxFactor}) {
  
    return new Palindromes(minFactor, maxFactor);
  }

  // Constructs the palindromes object
  constructor(minFactor, maxFactor) {

    // Since we don't know what the user will ask for, defer the computations
    // until a question (smallest, largest) is asked.
    // Note that the strategy we use is different in smallest and largest so it would not
    // be efficient to compute both up-front. The general method (going through all the pair of numbers)
    // is much smaller than computing smallest and largest once with the algorithm below.
    
    this.minFactor = minFactor;
    this.maxFactor = maxFactor;
  }

  // Returns the smallest palindrome in an object of the form 
  // {value: <number>, factors: [[n1,m1], ...]} where number = n1*m1.
  get smallest() {
  
    if (this.maxFactor < this.minFactor) throw new Error('min must be <= max');

    // Compute the smallest palindrome only when needed (lazy function)
    // but cache the result in case it is read more than once.
    if (this._smallest) return this._smallest;
  
    let value = Number.MAX_SAFE_INTEGER;
    let factors = [];
      
    // starting from the bottom
    for (let i = this.minFactor; i <= this.maxFactor; i++) {
      for (let j = i; j <= this.maxFactor; j++) {
        let number = i * j;
        // once we reach a number greater than the smallest palindrome, we can skip the
        // rest of this j index loop.
        // There could be smaller numbers in a larger i index loop but not in this j loop.
        // ex: assuming current smallest palindrome is 121, once we get to i=11,j=12 (132) we can
        // skip the rest of the j loop but we can't skip the rest of the i loop: i=12,j=10 (120) 
        // is lower than the 121 so needs to be evaluated.
        if (number > value) break;
        if (number == value) {
          // we found another factor for the current palindrome, add it to the list
          factors.push([i, j]);
        } else {
          // number < current palindrome so we need to check if it is a candidate
          if (Palindromes.isPalindrome(number)) {
            value = number;
            factors = [[i, j]];
          }
        }
      }
    }
  
    if (value == Number.MAX_SAFE_INTEGER) {
      // didn't find any palindrome
      this._smallest = {value: null, factors: []};
      // we may as well avoid computing the largest since there is none
      this._largest = {value: null, factors: []};
    } else {
      this._smallest = {value: value, factors: factors};
    }
    return this._smallest;
  }

  // Returns the largest palindrome in an object of the form 
  // {value: <number>, factors: [[n1,m1], ...]} where number = n1*m1.
  get largest() {
  
    if (this.maxFactor < this.minFactor) throw new Error('min must be <= max');
  
    // Compute the largest palindrome only when needed (lazy function)
    // but cache the result in case it is read more than once.
    if (this._largest) return this._largest;
    
    let value = 0;
    let factors = [];
        
    // starting from the top
    for (let j = this.maxFactor; j >= this.minFactor; j--) {
      for (let i = j; i >= this.minFactor; i--) {
        let number = i * j;
        // similarly to the logic in smallest, once we find a number smaller than 
        // the current palindrome, we can skip the rest of the j loop.
        if (number < value) break;
        if (number == value) {
          // we found another factor for the current palindrome, add it to the list
          factors.push([i, j]);
        } else {
          // number > current palindrome so we need to check if it is a candidate
          if (Palindromes.isPalindrome(number)) {
            value = number;
            factors = [[i, j]];
          }
        }
      }
    }
    
    if (value == 0) {
      // didn't find any palindrome
      this._largest = {value: null, factors: []};
      // we may as well avoid computing the largest since there is none
      this._smallest = {value: null, factors: []};
    } else {
      this._largest = {value: value, factors: factors};
    }
    return this._largest;
  }
}
