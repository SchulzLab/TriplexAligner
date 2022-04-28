# get_org ----------------------------------------------------------------

#' Return species appropriate org.db
#'
#' This function will return either the human or mouse org.db object
#' @param species either "human" or "hs" for human, or "mouse" or "mm" for mouse.
#' @keywords org transcripts species
#' @export
#' @import org.Hs.eg.db org.Mm.eg.db
#' @examples
#' get_org("human") # returns human org
#' get_org("hs") # returns human org
#' get_org("mouse") # returns mouse org
#' get_org("mm") # returns mouse org

get_org = function(species){
  if(species == "human" | species == "hs"){
    suppressMessages(require(org.Hs.eg.db))
    orgdb = org.Hs.eg.db
  } else if(species == "mouse" | species == "mm"){
    suppressMessages(require(org.Mm.eg.db))
    orgdb = org.Mm.eg.db
  } else {
    stop('Please specify either "human" or "hs" for human, or "mouse" or "mm" for mouse.')
  }
  return(orgdb)
}
