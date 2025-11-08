/*
An equilateral triangle has all three sides the same length.

An isosceles triangle has at least two sides the same length. (It is sometimes specified as having exactly two sides the same length, but for the purposes of this exercise we'll say at least two.)

A scalene triangle has all sides of different lengths.
*/
// This class defines Triangle and checks their properties
export class Triangle {

  // Constructs a Triangle from the length of its three sides.
  constructor(...sides) {
    if (sides.length != 3) throw new Error('The shape is not a triangle');
    this.sides = sides;
  }

  // Checks if the shape is a triangle (i.e. all sides have length > 0 and the sum of the
  // length of any two sides is greater or equal to the length of the third size)
  get isTriangle() {
    return this.sides[0] > 0 && this.sides[1] > 0 && this.sides[2] > 0
      && (this.sides[0] + this.sides[1]) >= this.sides[2]
      && (this.sides[0] + this.sides[2]) >= this.sides[1]
      && (this.sides[1] + this.sides[2]) >= this.sides[0];
  }

  // Checks if the Triangle is equilateral (i.e. all three sides have the same length).
  get isEquilateral() {
    return this.isTriangle
      && this.sides[0] === this.sides[1] 
      && this.sides[1] === this.sides[2];
  }

  // Checks if the Triangle is isosceles (i.e. at least two sides have the same length).
  get isIsosceles() {
    return this.isTriangle
      && ((this.sides[0] === this.sides[1]) || (this.sides[1] === this.sides[2])
          || (this.sides[0] === this.sides[2]));
  }

  // Checks if the Triangle is scalene (i.e. all sides have different length)
  get isScalene() {
    return this.isTriangle
      && this.sides[0] !== this.sides[1]
      && this.sides[1] !== this.sides[2]
      && this.sides[2] !== this.sides[0];
  }
}
