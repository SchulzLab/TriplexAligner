# align each code ---------------------------------------------------------

#' Returns alignments for each substitution matrix in a list
#' 
#' This function aligns two sequences using a substitution matrix learned by exprectation-maximisation from triplex-sequencing data, and returns a `data.frame` with results including Karlin-Altschul statistics.
#' @param rna_seq RNA sequence of interest 
#' @param dna_seq DNA sequence of interest
#' @param code_list list of substitution matrices returned by `get_codes()`
#' @param ka_list list of Karlin-Altschul parameters (list) returned by `get_ka_params()`.
#' @param species "human"/"hs" or "mouse"/"mm".
#' @keywords align triplex rna dna
#' @export

align_per_code = function(rna_seq, dna_seq, code_list, ka_list, species){
  require(data.table, quietly = T)
  align_list = lapply(1:length(code_list), function(code_index){
    aln = align(rna_seq = rna_seq, dna_seq = dna_seq, code = code_list[[code_index]], ka = ka_list[[code_index]], species = species)
    aln$Code = paste0('Code ', code_index)
    return(aln)
  })
  align_bind = rbindlist(align_list)
  return(align_bind)
}