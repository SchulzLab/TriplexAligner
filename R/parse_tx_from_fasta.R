# parse_tx_from_fasta -----------------------------------------------------

#' Returns transcript sequences as a DNAstringset from supplied fasta filepath
#' 
#' Uses `Biostrings` to parse transcript sequences from the supplied fasta file.
#' @param fasta Filepath to fasta file of RNAs of interest.
#' @keywords transcript sequence symbol gene fasta
#' @export
#' @examples 
#' # return a DNAstringset object containing sequences contained within foo.fa 
#' parse_tx_from_fasta(fasta = foo.fa) 

parse_tx_from_fasta = function(fasta){
  require(Biostrings, quietly = T)
  seqs = readDNAStringSet(fasta, format = 'fasta')
  tx_meta = data.frame(Name = names(seqs))
  return(list(sequences = seqs, meta = tx_meta))
}
