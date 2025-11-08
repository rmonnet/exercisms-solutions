package strand

var dnaToRna = map[rune]rune{'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U'}

func ToRNA(dna string) string {
	dnaStrand := []rune(dna)
    rnaStrand := make([]rune, len(dnaStrand))
    for i, dnaNucleotide := range dnaStrand {
        rnaStrand[i] = dnaToRna[dnaNucleotide]
    }
    return string(rnaStrand)
}
