# Parse DNA regions from bed file ---------------------------------

#' Returns DNA sequences as a DNAstringset for supplied genomic regions
#' 
#' Uses TxDb, org.db and BSgenome objects from the species of interest to retrieve promoter sequences of the supplied genes, flanked by a user-defined number of base pairs.
#' @param bed_file character vector of gene symbols e.g. c("GAPDH", "MALAT1") for human or c("Gapdh", "Malat1") for mouse.
#' @param species either "human" or "hs" for human, or "mouse" or "mm" for mouse.
#' @param up numeric, how many base pairs upstream of the transcription start site to consider. Default 0.
#' @param down numeric, how many base pairs downstream of the transcription start site to consider. Default 0.
#' @keywords promoter sequence symbol gene
#' @export
#' @examples 
#' # return DNA sequences of regions in bed file
#' parse_proms_from_symbols(bed = foo.bed, species = "human") 
#' # return DNA sequences of regions in bed file exctended by 500 base pairs in each direction
#' parse_proms_from_symbols(bed = foo.bed, species = "human", up = 500, down = 500)


parse_DNA_from_bed = function(bed_file, species, up = 0, down = 0){
  require(GenomicRanges, quietly = T)
  require(data.table, quietly = T)
  # databases
  orgdb = get_org(species = species)
  txdb = get_txdb(species = species)
  bs = get_bs(species = species)
  # ranges and sequences
  restrict = c(paste0('chr', 1:22), 'chrX', 'chrY', 'chrM')
  bed = fread(file = bed_file, sep = '\t')
  bed = bed[bed$V1 %in% restrict,]
  bed$V2 = bed$V2 - up
  bed$V3 = bed$V3 + down
  ranges = GRanges(seqnames = bed$V1, ranges = IRanges(start = bed$V2, end = bed$V3, names = bed$V4))
  range_seqs = getSeq(bs, ranges)
  meta = as.data.frame(ranges)
  meta$name = rownames(meta)
  return(list(sequences = range_seqs, meta = meta))
}
