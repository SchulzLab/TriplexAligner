# parse_alignment ---------------------------------------------------------

#' Parses an alignment output from `align` to a `data.frame` with key metrics.
#'
#' This function parses the output of `align` to a `data.frame` which contains key results.
#' @param alignment output of `align`.
#' @keywords align result data.frame
#' @export
#' @examples
#' \dontrun{
#' parse_alignment(alignment)
#' }

parse_alignment = function(alignment){
  RNAstart = alignment@subject@range@start
  RNAend = alignment@subject@range@start + alignment@subject@range@width
  DNAstart = alignment@pattern@range@start
  DNAend = alignment@pattern@range@start + alignment@pattern@range@width
  RNAseq = gsub('T', 'U', as.character(alignment@subject))
  DNAseq = as.character(alignment@pattern)
  alnScore = pwalign::score(alignment)
  return(data.frame(TxStart = RNAstart,
              TxEnd = RNAend,
              TxSeq = RNAseq,
              DNAStart = DNAstart,
              DNAEnd = DNAend,
              DNASeq = DNAseq,
              Score = alnScore))
}
