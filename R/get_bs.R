# get_bsgenome ----------------------------------------------------------------

#' Return species appropriate BSgenome object
#'
#' This function will return either the human or mouse UCSC BSGenome
#' @param species either "human" or "hs" for human, or "mouse" or "mm" for mouse.
#' @keywords BSgenome genome species
#' @export
#' @import BSgenome.Hsapiens.UCSC.hg38 BSgenome.Mmusculus.UCSC.mm10
#' @examples
#' get_bs("human") # returns human bs
#' get_bs("hs") # returns human bs
#' get_bs("mouse") # returns mouse bs
#' get_bs("mm") # returns mouse bs

get_bs = function(species){
  if(species == "human" | species == "hs"){
    bsGenome = BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
  } else if(species == "mouse" | species == "mm"){
    bsGenome = BSgenome.Mmusculus.UCSC.mm10::BSgenome.Mmusculus.UCSC.mm10
  } else {
    stop('Please specify either "human" or "hs" for human, or "mouse" or "mm" for mouse.')
  }
  return(bsGenome)
}
