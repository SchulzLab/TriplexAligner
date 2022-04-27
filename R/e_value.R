# e_value ----------------------------------------------------------------

#' Return *E* value of local alignment bit-score
#' 
#' This function will return the *E* value of a local alignment, calculated using Karlin-Altschul statistics
#' @param bit_score bit_score from local alignment, returned by `bit_score()`.
#' @param m Karlin-Altschul parameter, DNA sequence length.
#' @param n Karlin-Altschul parameter, RNA sequence length.
#' @param N Karlin-Altschul parameter, RNA database size (i.e. total transcriptome length).
#' @keywords score alignment Karlin Altschul
#' @export
#' @examples 
#' e_value(bit_score = 27.5, m = 3000, n = 750, N = 8323091082)

e_value = function(bit_score, m, n, N) {
  pairwiseE = m * n * 2^-bit_score
  databaseE = pairwiseE * (N/n)
  return(databaseE)
}