# 🔬 ZF11_13 Nearby Genes

This project shows peak annotation results for the `ZF11_ZF13.bed` Cut&Run dataset using [ChIPseeker](https://bioconductor.org/packages/release/bioc/html/ChIPseeker.html). Peaks were annotated to the nearest genes based on the mm10 mouse genome.


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

**Generated with:**  
- R  
- ChIPseeker  
- TxDb.Mmusculus.UCSC.mm10.knownGene  
- org.Mm.eg.db  



