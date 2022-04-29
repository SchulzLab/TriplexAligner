# align_all_tx ------------------------------------------------------------

#' Returns alignments between an RNA sequence and all supplied DNA sequences
#'
#' This function aligns two sequences using a substitution matrix learned by exprectation-maximisation from triplex-sequencing data, and returns a `data.frame` with results including Karlin-Altschul statistics.
#' @param rna RNA sequences of transcripts of interest along with metadata. List.
#' @param dna DNA sequences of interest along with metadata. List.
#' @param code_list list of substitution matrices returned by `get_codes()`
#' @param ka_list list of Karlin-Altschul parameters (list) returned by `get_ka_params()`.
#' @param species "human"/"hs" or "mouse"/"mm".
#' @keywords align triplex rna dna
#' @export
#' @import data.table

align_all_tx = function(rna, dna, code_list, ka_list, species){
  rna_list = lapply(1:length(rna$sequences), function(rna_index){
    show(rna_index)
    rna_aln = align_tx_against_dna(rna_seq = rna$sequences[[rna_index]], dna = dna, code_list = code_list, ka_list = ka_list, species = species)
    rna_aln$RNA_name = names(rna$sequences)[rna_index]
    return(rna_aln)
  })
  rna_bind = data.table::rbindlist(rna_list)
  return(rna_bind)
}
