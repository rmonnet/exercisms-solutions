package protein_translation

// proteins returns the list of aminoacid associated with the rna_strand.
// The second parameter indicates if the translation was successful.
proteins :: proc(rna_strand: string) -> ([]string, bool) {

	amino_acids: [dynamic]string
	for i := 0; i < len(rna_strand); i += 3 {
		if i + 3 > len(rna_strand) {
			delete(amino_acids)
			return nil, false
		}
		amino_acid := codon_to_amino_acid(rna_strand[i:i + 3])
		if amino_acid == "" {
			delete(amino_acids)
			return nil, false
		}
		if amino_acid == "STOP" {
			break
		}
		append(&amino_acids, amino_acid)
	}
	return amino_acids[:], true
}

codon_to_amino_acid :: proc(codon: string) -> string {

	amino_acid: string
	switch codon {
	case "AUG":
		amino_acid = "Methionine"
	case "UUU", "UUC":
		amino_acid = "Phenylalanine"
	case "UUA", "UUG":
		amino_acid = "Leucine"
	case "UCU", "UCC", "UCA", "UCG":
		amino_acid = "Serine"
	case "UAU", "UAC":
		amino_acid = "Tyrosine"
	case "UGU", "UGC":
		amino_acid = "Cysteine"
	case "UGG":
		amino_acid = "Tryptophan"
	case "UAA", "UAG", "UGA":
		amino_acid = "STOP"
	}
	return amino_acid
}
