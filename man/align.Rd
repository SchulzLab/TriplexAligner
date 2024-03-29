% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/align.R
\name{align}
\alias{align}
\title{Return maximal alignment of two sequences using TriplexAligner substitution matrix}
\usage{
align(rna_seq, dna_seq, code, ka, species)
}
\arguments{
\item{rna_seq}{RNA sequence of interest}

\item{dna_seq}{DNA sequence of interest}

\item{code}{Substitution matrix}

\item{ka}{Karlin-Altschul parameters (list).}

\item{species}{"human"/"hs" or "mouse"/"mm".}
}
\description{
This function aligns two sequences using a substitution matrix learned by exprectation-maximisation from triplex-sequencing data, and returns a \code{data.frame} with results including Karlin-Altschul statistics.
}
\keyword{align}
\keyword{dna}
\keyword{rna}
\keyword{triplex}
