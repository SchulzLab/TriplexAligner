# parse DNA sequence from FASTA -------------------------------------------

#' Returns DNA sequences as a DNAstringset from supplied fasta filepath
#'
#' Uses `Biostrings` to parse DNA sequences from the supplied fasta file.
#' @param fasta Filepath to fasta file of RNAs of interest.
#' @keywords transcript sequence symbol gene fasta
#' @export
#' @import Biostrings
#' @examples
#' \dontrun{
#' # return a DNAstringset object containing sequences contained within foo.fa
#' parse_DNA_from_fasta(fasta = foo.fa)
#' }

parse_DNA_from_fasta = function(fasta){
  seqs = Biostrings::readDNAStringSet(fasta, format = 'fasta')
  dna_meta = data.frame(Symbol = names(seqs))
  return(list(sequences = seqs, meta = dna_meta))
}
