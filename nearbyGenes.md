# 🔬 ZF11_13 Nearby Genes

This project shows peak annotation results for the `ZF11_ZF13.bed` Cut&Run dataset using [ChIPseeker](https://bioconductor.org/packages/release/bioc/html/ChIPseeker.html). Peaks were annotated to the nearest genes based on the mm10 mouse genome.

--- 

## 📈 Peak Annotation Summary

### 🧠 Genomic Feature Distribution

![Annotation Pie Chart](ZF11_13_peak_annotation_piechart.png)  
*Distribution of peaks across genomic features (e.g., Promoter, Exon, Intergenic).*

---

### 📍 Distance to TSS

![Distance to TSS](ZF11_13_peak_distance_to_TSS.png)  
*Distribution of peak distances from the transcription start sites (TSS).*

---

### 🔗 Annotation Category Overlap (UpSet Plot)

![UpSet Plot](ZF11_13_peak_upset_plot.png)  
*Overlap of peak annotations across multiple genomic categories.*

---

## 📄 Full Annotated Peaks Table

You can [download the full annotated peak list as a CSV file](./ZF11_13_peaks_annotated_nearby_genes.csv), which includes nearest genes, distances to TSS, and gene symbols.

---

## 🧬 Annotation File Header Explained

The annotated peak file produced by **ChIPseeker** contains a mix of original peak coordinates and gene annotation metadata.

### 🗂️ Columns Breakdown

| Column Name       | Description |
|-------------------|-------------|
| `seqnames`        | Chromosome name (e.g., `chr1`, `chrX`) |
| `start` / `end`   | Start and end positions of the peak |
| `width`           | Length of the peak (`end - start + 1`) |
| `strand`          | Strand info (`+`, `-`, or `*` if unspecified) |
| `V4` – `V10`      | Additional columns from the original BED file (e.g., name, score, etc.) |
| `annotation`      | Genomic location of the peak (e.g., Promoter, Intron, Intergenic) |
| `geneChr`         | Chromosome of the nearest gene |
| `geneStart`       | Gene start coordinate |
| `geneEnd`         | Gene end coordinate |
| `geneLength`      | Gene length in base pairs |
| `geneStrand`      | Strand of the gene (`+` or `-`) |
| `geneId`          | Entrez gene ID |
| `transcriptId`    | Transcript ID of the annotated gene |
| `distanceToTSS`   | Distance from the peak to the transcription start site (TSS) |
| `ENSEMBL`         | Ensembl gene ID |
| `SYMBOL`          | Official gene symbol (e.g., `Myc`, `Tp53`) |
| `GENENAME`        | Full gene name or description (e.g., `myelocytomatosis oncogene`) |

This table helps interpret which genes each peak might be regulating or associated with, especially in promoter or enhancer regions.

---



**Generated with:**  
- R  
- ChIPseeker  
- TxDb.Mmusculus.UCSC.mm10.knownGene  
- org.Mm.eg.db  



