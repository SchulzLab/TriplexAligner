# TriplexAligner
-------
An R package for sequence based prediction of RNA:DNA:DNA triple helix formation.

## Usage
The *TriplexAligner* R package works using the `TriplexAligner()` command of the same name. Here, the user can supply input RNA and DNA of various formats (explained below), along with specifying the species of interest. The output of `TriplexAligner()` is a `data.frame` providing local alignment results with accompanying score metrics and Karlin-Altschul statistics.

## Parameters
There are several required and optional parameters for the `TriplexAligner()` function, detailed below:
| Parameter | Description | Default |
| :---------| :---------- | :-------|
| `rna_input` | Input RNA. See `rna_format` for format options. | None |
| `dna_input` | Input DNA. See `dna_format` for format options. | None |
| `rna_format` | One of `"symbol"` or `"fasta"`. | None | 
| `dna_format` | One of `"symbol"`, `"fasta"` or `"bed"`. | None |
| `species` | Either `"human"`/`"hs"` or `"mouse"`/`"mm"`. | None |
| `up` | Number of base pairs upstream of supplied DNA region which is considered (`dna_format` must be one of `"symbol"` or `"bed"` for this to apply). | 0 |
| `down` | Number of base pairs downstream of supplied DNA region which is considered (`dna_format` must be one of `"symbol"` or `"bed"` for this to apply). | 0 |

## Examples
```
# Predict triplex formation between MALAT1 and the promoter of GAPDH
TriplexAligner(rna_input = 'MALAT1', dna_input = 'GAPDH', rna_format = 'symbol', dna_format = 'symbol', species = 'hs')
# Predict triplex formation between MALAT1 and DNA regions in a bed file (e.g. ATAC-sequencing peaks)
TriplexAligner(rna_input = 'MALAT1', dna_input = 'foo.bed', rna_format = 'symbol', dna_format = 'bed', species = 'hs')
# Predict triplex formation between MALAT1 & NEAT1 and DNA regions in a fasta file
TriplexAligner(rna_input = c('MALAT1', 'NEAT1'), dna_input = 'foo.fa', rna_format = 'symbol', dna_format = 'fasta', species = 'hs')
```
