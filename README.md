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
This is the parameter used to supply the RNA of interest to `TriplexAligner`. It may currently be supplied in two formats, specified by `rna_format`:
- `symbol` : Specifying that the input RNA is in the `symbol` format (a character vector of species-appropriate gene symbols e.g. `c("MALAT1", "NEAT1")` for humans, or `c("Malat1", "Neat1")` for mice) will lead *TriplexAligner* to retrieve all transcript sequences for each supplied symbol, as annotated by either *TxDb.Hsapiens.UCSC.hg38.knownGene* or *TxDb.Mmusculus.UCSC.mm10.knownGene*. Each transcript is then separately used as input to `TriplexAligner`.
- `fasta` : Specifying that that input RNA is in the `fasta` format means that the RNA sequences will be read from a corresponding fasta file supplied to `rna_input`. The headers in the fasta file will be assigned as the corresponding transcript names in the results. Note: there is no need to convert T to U.
### `dna_input`
This is the parameter used to supply the DNA of interest to `TriplexAligner`. It may currently be supplied in three formats, specified by `rna_format`:
- `symbol` : Specifying that the input DNA is in the `symbol` format (a character vector of species-appropriate gene symbols e.g. `c("GAPDH", "CDH5")` for humans, or `c("Gapdh", "Cdh5")` for mice) will lead *TriplexAligner* to retrieve all sequences surrounding the transcription start sites of each supplied gene symbol, as annotated by either *TxDb.Hsapiens.UCSC.hg38.knownGene* or *TxDb.Mmusculus.UCSC.mm10.knownGene*. The number of base pairs upstream and downstream of the transcription start site taken into consideration may be specified using the `up` and `down` parameters of `TriplexAligner()`.
- `fasta` : Specifying that that input DNA is in the `fasta` format means that the DNA sequences will be read from a corresponding fasta file supplied to `dna_input`. The headers in the fasta file will be assigned as the corresponding DNA region names in the results.
- `bed` : Specifying that the DNA regions of interest are supplied in the `bed` format means that sequences corresponding to the supplied region bed file (e.g. `foo.bed`) will be retrieved using the *GenomicRanges* and species-appropriate *BSgenome* packages, and then used in `TriplexAligner()`. The input bed file should be a 4-column file with the columns being *chromosome*, *start*, *stop*, and *name*. Note: the bed file should have no header, and names must be unique, seeing as the names in the fourth column of the bed file will be used as the names of the corresponding sequences.
### `species`
This parameter is used to ensure that the correct sequences are retrieved and considered for RNA:DNA:DNA triple helix formation, and that Karlin-Altschul statistics are calculated correctly. At the present time, only human (`"human"`/`"hs"`) and mouse (`"mouse"`/`"mm"`) are supported, but this will be expanded in the future.
### `up`
This parameter extends the region supplied by either the `symbol` or `bed` DNA formats by a user-defined number of base pairs upstream. This may be used to consider wider areas around gene transcription start sites in the case that `input_DNA` is in the `symbol` format, or to extend regions supplied in the `bed` format.  
### `down`
This parameter extends the region supplied by either the `symbol` or `bed` DNA formats by a user-defined number of base pairs downstream. This may be used in conjunction with `up` to consider wider areas around gene transcription start sites in the case that `input_DNA` is in the `symbol` format, or to extend regions supplied in the `bed` format.  

## Output
*TriplexAligner* outputs a `data.frame` with one row per transcript/DNA/code combination. Note: if `rna_input` is supplied in the with `rna_format = "symbol"` then all transcripts from the species-appropriate `TxDb` package will be considered. *TriplexAligner* uses Karlin-Altschul statistics to assess local alignments, and corresponding values are provided in the output `data.frame`. An example output is shown below:

|TxStart |TxEnd |TxSeq  |DNAStart |DNAEnd |DNASeq |Score  |BitScore |EValue      |logE  |Code   |DNA_name |RNA_name |
|:-------|:-----|:------|:--------|:------|:------|:------|:--------|:-----------|:-----|:------|:--------|:--------|
|147     |197   |UCC... |2208     |2258   |GGT... |261.05 |133.76   |0.00        |26.87 |Code 1 |DAD1     |foo      |
|589     |597   |UCU... |863      |871    |ACT... |35.47  |20.33    |18989690.25 |-7.28 |Code 2 |DAD1     |foo      |
|698     |711   |ACA... |1240     |1253   |ACT... |62.32  |33.46    |2111.98     |-3.32 |Code 3 |DAD1     |foo      |
|698     |711   |ACA... |994      |1007   |TGC... |50.63  |31.30    |9474.47     |-3.98 |Code 4 |DAD1     |foo      |
|836     |858   |UGG... |2173     |2195   |ACC... |61.31  |36.50    |257.60      |-2.41 |Code 5 |DAD1     |foo      |
|714     |757   |UGG... |849      |892    |GAA... |59.84  |35.31    |584.38      |-2.77 |Code 6 |DAD1     |foo      |
|805     |837   |AUA... |562      |594    |ATA... |56.78  |32.56    |3942.06     |-3.60 |Code 7 |DAD1     |foo      |
|572     |670   |UUU... |1653     |1751   |TTC... |49.24  |29.10    |43423.78    |-4.64 |Code 8 |DAD1     |foo      |
|21      |61    |CUU... |977      |1017   |TTG... |225.18 |115.65   |0.00        |21.42 |Code 1 |GAPDH    |foo      |
|589     |597   |UCU... |2475     |2483   |TCT... |35.23  |20.20    |20703348.37 |-7.32 |Code 2 |GAPDH    |foo      |
|695     |711   |AGU... |870      |886    |TGC... |59.26  |31.92    |6163.40     |-3.79 |Code 3 |GAPDH    |foo      |
|698     |711   |ACA... |1541     |1554   |CGC... |50.98  |31.50    |8207.92     |-3.91 |Code 4 |GAPDH    |foo      |
|834     |875   |GAU... |2361     |2402   |CTA... |60.29  |35.92    |383.46      |-2.58 |Code 5 |GAPDH    |foo      |
|736     |764   |GUA... |842      |870    |TGG... |66.66  |39.15    |40.88       |-1.61 |Code 6 |GAPDH    |foo      |
|177     |199   |CGC... |1541     |1563   |CGC... |58.21  |33.32    |2322.41     |-3.37 |Code 7 |GAPDH    |foo      |
|573     |691   |UUC... |381      |499    |TCA... |58.02  |34.04    |1414.54     |-3.15 |Code 8 |GAPDH    |foo      |
|630     |688   |UAU... |2562     |2620   |TCG... |259.83 |133.14   |0.00        |26.68 |Code 1 |CD40     |foo      |
|589     |597   |UCU... |1082     |1090   |ACA... |35.59  |20.39    |18186809.85 |-7.26 |Code 2 |CD40     |foo      |
|698     |711   |ACA... |1089     |1102   |ACA... |61.41  |33.00    |2904.10     |-3.46 |Code 3 |CD40     |foo      |
|698     |711   |ACA... |2429     |2442   |CGC... |51.07  |31.56    |7910.57     |-3.90 |Code 4 |CD40     |foo      |
|173     |189   |UUA... |295      |311    |AAT... |62.64  |37.24    |153.35      |-2.19 |Code 5 |CD40     |foo      |
|714     |757   |UGG... |853      |896    |GAA... |59.84  |35.31    |584.38      |-2.77 |Code 6 |CD40     |foo      |
|76      |98    |AAA... |2041     |2063   |AAA... |71.25  |40.28    |18.64       |-1.27 |Code 7 |CD40     |foo      |
|589     |672   |UCU... |1740     |1823   |TGT... |52.93  |31.18    |10297.54    |-4.01 |Code 8 |CD40     |foo      |
