# get_txdb ----------------------------------------------------------------

#' Return species appropriate transcript database
#'
#' This function will return either the human or mouse UCSC transcript databases
#' @param species either "human" or "hs" for human, or "mouse" or "mm" for mouse.
#' @keywords txdb transcripts species
#' @export
#' @import TxDb.Hsapiens.UCSC.hg38.knownGene TxDb.Mmusculus.UCSC.mm10.knownGene
#' @examples
#' get_txdb("human") # returns human txdb
#' get_txdb("hs") # returns human txdb
#' get_txdb("mouse") # returns mouse txdb
#' get_txdb("mm") # returns mouse txdb

get_txdb = function(species){
  if(species == "human" | species == "hs"){
    suppressMessages(require(TxDb.Hsapiens.UCSC.hg38.knownGene))
    txdb = TxDb.Hsapiens.UCSC.hg38.knownGene
  } else if(species == "mouse" | species == "mm"){
    suppressMessages(require(TxDb.Mmusculus.UCSC.mm10.knownGene))
    txdb = TxDb.Mmusculus.UCSC.mm10.knownGene
  } else {
    stop('Please specify either "human" or "hs" for human, or "mouse" or "mm" for mouse.')
  }
  return(txdb)
}
