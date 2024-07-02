library(TriplexAligner)
source("parse_args.R")


triplexaligner <- function() {
  if (!dir.exists("outputs")) {
    dir.create(output_path, recursive = TRUE)
  }
  
  seq_data <- read_sequence()
  seq <- seq_data$seq
  seq_id <- seq_data$seq_id
  dna_format <- seq_data$dna_format
  print(dna_format)
  
  res <- TriplexAligner(
    rna_input = c('MALAT1', 'NEAT1'),
    dna_input = seq,
    rna_format = 'symbol',
    dna_format = dna_format,
    species = 'hs'
  )
  
  output_csv_path = file.path("outputs", paste0(seq_id, ".csv"))
  write.csv(res, file = output_csv_path, row.names = FALSE)
}


read_sequence <- function() {
  if (!is.null(opt$fasta) && file.exists(file.path("example", opt$fasta))) {
    seq <- file.path("example", opt$fasta)
    seq_id <- tools::file_path_sans_ext(basename(opt$fasta))
    dna_format = "fasta"
    } else {
    seq <- opt$sequence
    seq_id <- opt$sequence_id
    dna_format = "text"
  }
  
  return(list(seq = seq, seq_id = seq_id, dna_format = dna_format))
}

if (!interactive()) {
  triplexaligner()
}