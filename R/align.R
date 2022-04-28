# align -------------------------------------------------------------------

#' Return maximal alignment of two sequences using TriplexAligner substitution matrix
#'
#' This function aligns two sequences using a substitution matrix learned by exprectation-maximisation from triplex-sequencing data, and returns a `data.frame` with results including Karlin-Altschul statistics.
#' @param rna_seq RNA sequence of interest
#' @param dna_seq DNA sequence of interest
#' @param code Substitution matrix
#' @param ka Karlin-Altschul parameters (list).
#' @param species "human"/"hs" or "mouse"/"mm".
#' @keywords align triplex rna dna
#' @export
#' @import Biostrings

align = function(rna_seq, dna_seq, code, ka, species) {
  require(Biostrings, quietly = T)
  aln = Biostrings::pairwiseAlignment(pattern = dna_seq, subject = rna_seq, type = "local", substitutionMatrix = code, gapOpening = Inf, gapExtension = Inf)
  score = aln@score
  bit_score = bit_score(score = score, lambda = ka$Lambda, k = ka$K)
  e_value = e_value(bit_score = bit_score, m = length(dna_seq), n = length(rna_seq), N = get_transcriptome_length(species = species))
  log_e = -log10(e_value)
  out_df = outList = data.frame(parse_alignment(aln), BitScore = bit_score, EValue = e_value, logE = log_e)
  return(out_df)
}
