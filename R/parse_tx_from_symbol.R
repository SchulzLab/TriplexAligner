# parse_tx_from_symbol --------------------------------------------

#' Returns transcript sequence as a DNAstring from supplied gene symbol
#'
#' Uses TxDb, org.db and BSgenome objects from the species of interest to retrieve transcript sequences of the supplied gene.
#' @param symbol Gene symbol e.g. "GAPDH", "MALAT1" for human or "Gapdh", "Malat1" for mouse.
#' @param species either "human" or "hs" for human, or "mouse" or "mm" for mouse.
#' @keywords transcript sequence symbol gene
#' @export
#' @import AnnotationDbi
#' @examples
#' # return all human NEAT1 transcript sequences
#' parse_tx_from_symbol(symbol = "NEAT1", species = "human")
#' # return all mouse NEAT1 transcript sequences
#' parse_tx_from_symbol(symbol = "Neat1", species = "mouse")

parse_tx_from_symbol = function(symbol, species){
  orgdb = get_org(species = species)
  txdb = get_txdb(species = species)
  bs = get_bs(species = species)
  entrez = suppressMessages(AnnotationDbi::select(x = orgdb, keys = symbol, columns = 'ENTREZID', keytype = 'SYMBOL'))
  allTx = GenomicFeatures::exonsBy(txdb, by = 'tx')
  tx = suppressMessages(AnnotationDbi::select(x = txdb, keys = entrez$ENTREZID, columns = 'TXID', keytype = 'GENEID'))
  tx$SYMBOL = entrez$SYMBOL[match(tx$GENEID, entrez$ENTREZID)]
  tx$NAME = paste0(tx$SYMBOL, tx$TXID)
  txRanges = allTx[names(allTx) %in% tx$TXID]
  tx_meta = as.data.frame(txRanges)
  tx_meta$symbol = tx$SYMBOL[match(tx_meta$group_name, tx$TXID)]
  transcriptFastas = GenomicFeatures::extractTranscriptSeqs(x = bs, transcripts = txRanges)
  names(transcriptFastas) = tx$NAME[match(names(transcriptFastas), tx$TXID)]
  return(list(sequences = transcriptFastas, meta = tx_meta))
}
