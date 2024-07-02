parse_tx_from_text = function(seq){
  seqs = Biostrings::DNAString(seq)
  tx_meta = data.frame(Name = "Sequence"))
  return(list(sequences = seqs, meta = tx_meta))
}
