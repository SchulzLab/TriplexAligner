# Parse promoter regions from symbol list ---------------------------------

#' Returns promoter sequences as a DNAstring for supplied gene symbols
#'
#' Uses TxDb, org.db and BSgenome objects from the species of interest to retrieve promoter sequences of the supplied genes, flanked by a user-defined number of base pairs.
#' @param symbols character vector of gene symbols e.g. c("GAPDH", "MALAT1") for human or c("Gapdh", "Malat1") for mouse.
#' @param species either "human" or "hs" for human, or "mouse" or "mm" for mouse.
#' @param up numeric, how many base pairs upstream of the transcription start site to consider.
#' @param down numeric, how many base pairs downstream of the transcription start site to consider.
#' @keywords promoter sequence symbol gene
#' @export
#' @import AnnotationDbi
#' @examples
#' # return promoter sequences (2500 bp upstream and 500 bp downstream of TSS) of several human genes
#' parse_proms_from_symbols(symbols = c("GAPDH","CDH5","NANOG","NOXO1"), species = "human", up = 2500, down = 500)
#' # return promoter sequences (1000 bp upstream and 1000 bp downstream of TSS) of several mouse genes
#' parse_proms_from_symbols(symbols = c("Gapdh","Cdh5","Nanog","Noxo1"), species = "mouse", up = 1000, down = 1000)


parse_proms_from_symbols = function(symbols, species, up = 2500, down = 500){
  # databases
  orgdb = get_org(species = species)
  txdb = get_txdb(species = species)
  bs = get_bs(species = species)
  # ranges and sequences
  entrez = suppressMessages(AnnotationDbi::select(x = orgdb, keys = symbols, columns = 'ENTREZID', keytype = 'SYMBOL'))
  allGenes = suppressMessages(GenomicFeatures::genes(txdb))
  promRanges = GenomicFeatures::promoters(allGenes[names(allGenes) %in% entrez$ENTREZID], upstream = up, downstream = down)
  promMeta = data.frame(promRanges)
  promMeta$Symbol = entrez$SYMBOL[match(promMeta$gene_id, entrez$ENTREZID)]
  promoterSeqs = Biostrings::getSeq(bs, promRanges)
  names(promoterSeqs) = symbols
  return(list(sequences = promoterSeqs, meta = promMeta))
}
