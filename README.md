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
## Details
### `rna_input`
This is the parameter used to supply the RNA of interest to `TriplexAligner`. It may currently be suppled in two formats, specified by `rna_format`:
- `symbol` : Specifying that the input RNA is in the `symbol` format (a character vector of species-appropriate gene symbols e.g. `c("MALAT1", "NEAT1")` for humans, or `c("Malat1", "Neat1")` for mice) will lead *TriplexAligner* to retrieve all transcript sequences for each supplied symbol, as annotated by either *TxDb.Hsapiens.UCSC.hg38.knownGene* or *TxDb.Mmusculus.UCSC.mm10.knownGene*. Each transcript is then separately used as input to `TriplexAligner`.
- `fasta` : Specifying that that input RNA is in the `fasta` format means that the RNA sequences will be read from a corresponding fasta file supplied to `rna_input`. The headers in the fasta file will be assigned as the corresponding transcript names in the results. Note: there is no need to convert T &rarr U.
### `dna_input`
This is the parameter used to supply the DNA of interest to `TriplexAligner`. It may currently be suppled in three formats, specified by `rna_format`:
- `symbol` : Specifying that the input DNA is in the `symbol` format (a character vector of species-appropriate gene symbols e.g. `c("GAPDH", "CDH5")` for humans, or `c("Gapdh", "Cdh5")` for mice) will lead *TriplexAligner* to retrieve all sequences surrounding the transcription start sites of each supplied gene symbol, as annotated by either *TxDb.Hsapiens.UCSC.hg38.knownGene* or *TxDb.Mmusculus.UCSC.mm10.knownGene*. The number of base pairs upstream and downstream of the transcription start site taken into consideration may be specified using the `up` and `down` parameters of `TriplexAligner()`.
- `fasta` : Specifying that that input DNA is in the `fasta` format means that the DNA sequences will be read from a corresponding fasta file supplied to `dna_input`. The headers in the fasta file will be assigned as the corresponding DNA region names in the results.
- `bed` : Specifying that the DNA regions of interest are supplied in the `bed` format means that sequences corresponding to the supplied region bed file (e.g. `foo.bed`) will be retrieved using the *GenomicRanges* and species-appropriate *BSgenome* packages, and then used in `TriplexAligner()`. The input bed file should be a 4-column file with the columns being *chromosome*, *start*, *stop*, and *name*. Note: the bed file should have no header, and names must be unique, seeing as the names in the fourth column of the bed file will be used as the names of the corresponding sequences.
### `species`
This parameter is used to ensure that the correct sequences are retrieved and considered for RNA:DNA:DNA triple helix formation, and that Karlin-Altschul statistics are calcaulated correctly. At the present time, only human (`"human"`/`"hs"`) and mouse (`"mouse"`/`"mm"`) are supported, but this will be expanded in the future.
### `up`
This parameter extends the region supplied by either the `symbol` or `bed` DNA formats by a user-defined number of base pairs upstream. This may be used to consider wider areas around gene transcription start sites in the case that `input_DNA` is in the `symbol` format, or to extend regions supplied in the `bed` format.  
### `down`
This parameter extends the region supplied by either the `symbol` or `bed` DNA formats by a user-defined number of base pairs downstream. This may be used in conjunction with `up` to consider wider areas around gene transcription start sites in the case that `input_DNA` is in the `symbol` format, or to extend regions supplied in the `bed` format.  
