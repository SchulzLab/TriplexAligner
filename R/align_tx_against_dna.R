# Align tx against all DNA ------------------------------------------------

#' Returns alignments between an RNA sequence and all supplied DNA sequences
#'
#' This function aligns two sequences using a substitution matrix learned by exprectation-maximisation from triplex-sequencing data, and returns a `data.frame` with results including Karlin-Altschul statistics.
#' @param rna_seq RNA sequence of interest
#' @param dna DNA sequences of interest along with metadata. List.
#' @param code_list list of substitution matrices returned by `get_codes()`
#' @param ka_list list of Karlin-Altschul parameters (list) returned by `get_ka_params()`.
#' @param species "human"/"hs" or "mouse"/"mm".
#' @keywords align triplex rna dna
#' @export
#' @import data.table

align_tx_against_dna = function(rna_seq, dna, code_list, ka_list, species){
  dna_aln_list = lapply(1:length(dna$sequences), function(dna_index){
    dna_aln = align_per_code(rna_seq = rna_seq, dna_seq = dna$sequences[[dna_index]], code_list = code_list, ka_list = ka_list, species = species)
    dna_aln$DNA_name = dna$meta$Symbol[dna_index]
    return(dna_aln)
  })
  dna_aln_bind = data.table::rbindlist(dna_aln_list)
  return(dna_aln_bind)
}
