// Package triangle provides operations to test the properties of a triangle.
package triangle


// Kind represents a kind of triangle
type Kind int

const (
    NaT Kind = iota // not a triangle
    Equ // equilateral
    Iso // isosceles
    Sca // scalene
)

// KindFromSides should have a comment documenting it.
func KindFromSides(a, b, c float64) Kind {
    if a <= 0 || b <= 0 || c <= 0 || (a+b) < c || (a+c) < b || (b+c) < a {
        return NaT
    }
	if a == b && b == c {
        return Equ
    }
    if a == b || b == c || a == c {
        return Iso
    }
    return Sca
}
