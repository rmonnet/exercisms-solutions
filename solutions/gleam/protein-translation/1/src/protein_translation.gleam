import gleam/list
import gleam/string

fn rna_to_codons(rna: String) -> List(String) {
  rna |> string.to_graphemes |> list.sized_chunk(3) |> list.map(string.concat)
}

fn codon_to_protein(codon: String) -> Result(String, Nil) {
   case codon {
    "AUG" -> Ok("Methionine")
    "UUU" -> Ok("Phenylalanine")
    "UUC" -> Ok("Phenylalanine")
    "UUA" -> Ok("Leucine")
    "UUG" -> Ok("Leucine")
    "UCU" -> Ok("Serine")
    "UCC" -> Ok("Serine")
    "UCA" -> Ok("Serine")
    "UCG" -> Ok("Serine")
    "UAU" -> Ok("Tyrosine")
    "UAC" -> Ok("Tyrosine")
    "UGU" -> Ok("Cysteine")
    "UGC" -> Ok("Cysteine")
    "UGG" -> Ok("Tryptophan")
    "UAA" -> Ok("STOP")
    "UAG" -> Ok("STOP")
    "UGA" -> Ok("STOP")
    _ -> Error(Nil)
  }
}

fn codons_to_proteins(codons: List(String), acc: List(String)) -> Result(List(String), Nil) {
 case codons {
  [] -> Ok(list.reverse(acc))
  [codon, ..rest] -> case codon_to_protein(codon) {
    Ok(protein) if protein == "STOP" -> Ok(list.reverse(acc))
    Ok(protein) -> codons_to_proteins(rest, [protein, ..acc])
    Error(_) -> Error(Nil)
  }
 }
}

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  codons_to_proteins(rna_to_codons(rna), [])
}
