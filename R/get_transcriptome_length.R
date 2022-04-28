# get_transcriptome_length ----------------------------------------------------------------

#' Returns the total transcriptome length of the appropriate species
#'
#' This function will return the total length of either the human or mouse transcriptome, as annotated by the UCSC TxDB packages.
#' @param species raw score from local alignment.
#' @keywords transcriptome length
#' @export
#' @examples
#' # Get length of annotated human transcriptome
#' get_transcriptome_length(species = "human")
#' # Get length of annotated mouse transcriptome
#' get_transcriptome_length(species = "mouse")

get_transcriptome_length = function(species){
  txdb = get_txdb(species = species)
  totalLength = sum(width(unlist(transcriptsBy(x = txdb, by = 'gene'))))
  return(totalLength)
}
