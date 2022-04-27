# parse DNA sequence from FASTA -------------------------------------------

#' Returns DNA sequences as a DNAstringset from supplied fasta filepath
#' 
#' Uses `Biostrings` to parse DNA sequences from the supplied fasta file.
#' @param fasta Filepath to fasta file of RNAs of interest.
#' @keywords transcript sequence symbol gene fasta
#' @export
#' @examples 
#' # return a DNAstringset object containing sequences contained within foo.fa 
#' parse_DNA_from_fasta(fasta = foo.fa) 

parse_DNA_from_fasta = function(fasta){
  require(Biostrings, quietly = T)
  seqs = readDNAStringSet(fasta, format = 'fasta')
  dna_meta = data.frame(Name = names(seqs))
  return(list(sequences = seqs, meta = tx_meta))
}
