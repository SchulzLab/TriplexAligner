# TriplexAligner ----------------------------------------------------------

#' Predicts RNA:DNA:DNA triple helix formation between RNAs and DNA regions of interest
#' 
#' This function implements RNA:DNA:DNA triple helix mapping codes learned by expectation-maximisation from triplex-sequencing data as substitution matrices in local alignment to predict sites of RNA-DNA interaction.
#' @param rna_input Input RNA. See `rna_format` for options. 
#' @param dna_input Input DNA. See `dna_format` for options.
#' @param rna_format One of "symbol" or "fasta".
#' @param dna_format One of "symbol", "fasta" or "bed".
#' @param code_list list of substitution matrices returned by `get_codes()`
#' @param ka_list list of Karlin-Altschul parameters (list) returned by `get_ka_params()`.
#' @param species "human"/"hs" or "mouse"/"mm".
#' @param up How many base pairs upstream of TSS to consider as promoter region. Default: 2500.
#' @param down How many base pairs downstream of TSS to consider as promoter region. Default: 500.
#' @keywords align triplex rna dna
#' @export
#' @examples 
#' # Predict triplex formation between MALAT1 and the promoter of GAPDH
#' TriplexAligner(rna_input = 'MALAT1', dna_input = 'GAPDH', rna_format = 'symbol', dna_format = 'symbol', species = 'hs')
#' # Predict triplex formation between MALAT1 and DNA regions in a bed file (e.g. ATAC-sequencing peaks)
#' TriplexAligner(rna_input = 'MALAT1', dna_input = 'foo.bed', rna_format = 'symbol', dna_format = 'bed', species = 'hs')
#' # Predict triplex formation between MALAT1 & NEAT1 and DNA regions in a fasta file
#' TriplexAligner(rna_input = c('MALAT1', 'NEAT1'), dna_input = 'foo.fa', rna_format = 'symbol', dna_format = 'bed', species = 'hs')

TriplexAligner = function(rna_input, dna_input, rna_format, dna_format, code_list = get_codes(), ka_list = get_ka_params(), species, up = 2500, down = 500){
  # Parse RNA sequences from input
  if(rna_format == 'symbol'){
    rna = parse_tx_from_symbol(symbol = rna_input, species = species)
  } else if(rna_format == 'fasta'){
    rna = parse_tx_from_fasta(fasta = rna_input)
  } else {
    stop('Please specify rna_format as one of "symbol" or "fasta"')
  }
  # Parse DNA sequences from input
  if(dna_format == 'symbol'){
    dna = parse_proms_from_symbols(symbols = dna_input, species = species, up = up, down = down)
  } else if(dna_format == 'fasta'){
    dna = parse_DNA_from_fasta(fasta = dna_input)
  } else if(dna_format == 'bed'){
    dna = parse_DNA_from_bed(bed_file = dna_input, species = species, up = up, down = down)
  } else {
    stop('Please specify dna_format as one of "symbol", "fasta" or "bed"')
  }
  triplex_aln = align_all_tx(rna = rna, dna = dna, code_list = code_list, ka_list = ka_list, species = species)
  #aln_bind = rbindlist(aln_list)
  return(triplex_aln)
}
