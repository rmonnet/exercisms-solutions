// Package protein provides operations to convert between codons and proteins.
package protein

import "errors"

// Stop represents a codon that stops the production of proteins.
const stop = "STOP"

// AminoAcids maps the codons to the amino acids they represent.
var aminoAcids = map[string]string{
    "AUG": "Methionine", 
    "UUU": "Phenylalanine", "UUC": "Phenylalanine",
	"UUA": "Leucine", "UUG": "Leucine",
	"UCU": "Serine", "UCC": "Serine", "UCA": "Serine", "UCG": "Serine",
	"UAU": "Tyrosine", "UAC": "Tyrosine",
	"UGU": "Cysteine", "UGC": "Cysteine",
	"UGG": "Tryptophan",
	"UAA": stop, "UAG": stop, "UGA": stop}

// ErrStop defines the error generated when a STOP codon is encountered.
var ErrStop = errors.New("STOP encountered")

// ErrInvalidBase defines the error generated when a codon not associated with
// an amino acid is encountered.
var ErrInvalidBase = errors.New("Invalid base")

// FromRNA converts a sequence of RNA into a sequence of amino acids.
func FromRNA(rna string) ([]string, error) {
	rnaseq := []rune(rna)
    proteins := []string{}
    for i:=0; i < len(rnaseq); i += 3 {
        aminoAcid, err := FromCodon(string(rnaseq[i:i+3]))
        if err == ErrStop {
            return proteins, nil
        }
        if err != nil {
            return nil, err
        }
        proteins = append(proteins, aminoAcid)
    }
    return proteins, nil
}

// FromCodon computes the amino acid associated with the codon.
//
// It returns ErrInvalidBase if the codon doesn't map to any known amino acid.
// It returns ErrStop if the codon maps to STOP.
func FromCodon(codon string) (string, error) {
	aminoAcid, ok := aminoAcids[codon]
    if ! ok {
        return "", ErrInvalidBase
    }
    if aminoAcid == stop {
        return "", ErrStop
    }
    return aminoAcid, nil
}
