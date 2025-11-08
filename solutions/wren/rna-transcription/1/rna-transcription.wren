var TRANSLATION = {"G":"C", "C":"G", "T":"A", "A":"U"}

class DNA {
  
  static toRNA(strand) {
    var res = strand.replace("G", "X")
    res = res.replace("C", "G")
    res = res.replace("X", "C")
    res = res.replace("A", "U")
    res = res.replace("T", "A")
    return res
  }
}
