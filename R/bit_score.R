# bit_score ----------------------------------------------------------------

#' Return bit-score of local alignment
#' 
#' This function will return either the human or mouse UCSC transcript databases
#' @param score raw score from local alignment.
#' @param lambda Karlin-Altschul parameter.
#' @param k Karlin-Altschul parameter.
#' @keywords score alignment Karlin Altschul
#' @export
#' @examples 
#' bit_score(score = 50, lambda = 0.35, k = 0.2)

bit_score = function(score, lambda, k) {
  bitScore = as.numeric((lambda*score - log(k)) / log(2))
  return(bitScore)
}
