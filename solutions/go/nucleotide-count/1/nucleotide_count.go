package dna

import "errors"

// Histogram is a mapping from nucleotide to its count in given DNA.
type Histogram map[rune]int

// NewHistogram creates a Nucleotide histogram and initialize each count to 0.
func NewHistogram() Histogram {
    return Histogram{'A': 0, 'C':0, 'G': 0, 'T': 0}
}

// DNA is a list of nucleotides.
type DNA string

// Counts generates a histogram of valid nucleotides in the given DNA.
// Returns an error if d contains an invalid nucleotide.
func (d DNA) Counts() (Histogram, error) {
	histogram := NewHistogram()
    for _, nucleotide := range d {
        _, ok := histogram[nucleotide]
        if ! ok {
            return nil, errors.New("Invalid nucleotide")
        }
        histogram[nucleotide] += 1
    }
	return histogram, nil
}
