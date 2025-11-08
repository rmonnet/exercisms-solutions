import gleam/list
import gleam/string

fn rna_to_codons(rna: String) -> List(String) {
  rna |> string.to_graphemes |> list.sized_chunk(3) |> list.map(string.concat)
}

fn codon_to_protein(codon: String) -> Result(String, Nil) {
   case codon {
    "AUG"  -> Ok("Methionine")
    "UUU" | "UUC" -> Ok("Phenylalanine")
    "UUA" | "UUG" -> Ok("Leucine")
    "UCU" | "UCC" | "UCA" | "UCG" -> Ok("Serine")
    "UAU" | "UAC" -> Ok("Tyrosine")
    "UGU" | "UGC" -> Ok("Cysteine")
    "UGG" -> Ok("Tryptophan")
    "UAA" | "UAG" | "UGA" -> Ok("STOP")
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
