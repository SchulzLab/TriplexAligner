library(optparse)


option_list <- list(
  make_option(c("-f", "--fasta"), type = "character", default = NULL,
              help = "FASTA file path", metavar = "character"),
  make_option(c("-s", "--sequence"), type = "character", default = NULL,
              help = "Sequence to be processed", metavar = "character"),
  make_option(c("-i", "--sequence_id"), type = "character", default = NULL,
              help = "Sequence ID", metavar = "character")
)


opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)

# Check if DNA sequence, regardless of input format, is provided
if (is.null(opt$sequence) && is.null(opt$fasta)) {
  print_help(opt_parser)
  stop("Error: FASTA file path or Sequence and its ID must be provided.", call. = FALSE)
}

# Check if the sequence ID and sequence are provided
if (!is.null(opt$sequence) && is.null(opt$sequence_id) && is.null(opt$fasta) ||
    is.null(opt$sequence) && !is.null(opt$sequence_id) && is.null(opt$fasta)) {
  print_help(opt_parser)
  stop("Error: Sequence ID and Sequence must be passed.", call. = FALSE)
}

# Warn user that when both --fasta and --sequence are provided --fasta will take precedence
if (!is.null(opt$sequence) && !is.null(opt$fasta)) {
  cat("Warning: Both --fasta and --sequence are provided. --fasta will take precedence.\n")
}