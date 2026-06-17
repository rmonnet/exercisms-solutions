func toRna(_ dna: String) -> String {
  var rna = Array(dna)
  for i in 0..<rna.count {
    rna[i] = transcribe(from: rna[i])
  }
  return String(rna)
}

func transcribe(from: Character) -> Character {
  return switch from {
  case "G": "C"
  case "C": "G"
  case "T": "A"
  case "A": "U"
  default: fatalError("Invalid DNA Nucleaotide")
  }
}
