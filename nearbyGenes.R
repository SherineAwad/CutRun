library(ChIPseeker)
library(TxDb.Mmusculus.UCSC.mm10.knownGene)  # Transcript database for mouse mm10
library(org.Mm.eg.db)                        # Mouse gene annotation database


peakfile <- "ZF11_ZF13.bed"
peaks <- readPeakFile(peakfile)

txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene

# Fix seqlevels style of peaks to UCSC to match TxDb
seqlevelsStyle(peaks) <- "UCSC"

peakAnno <- annotatePeak(peaks,
                         TxDb=txdb,
                         tssRegion=c(-3000, 3000),
                         annoDb="org.Mm.eg.db")

print(as.data.frame(peakAnno))


write.csv(as.data.frame(peakAnno), file="ZF11_13_peaks_annotated_nearby_genes.csv", row.names=FALSE)



png("ZF11_13_peak_annotation_piechart.png", width=800, height=800)
plotAnnoPie(peakAnno)
dev.off()

# Save plot of distance to TSS
png("ZF11_13_peak_distance_to_TSS.png", width=800, height=600)
plotDistToTSS(peakAnno)
dev.off()

# Save UpSet plot of annotation categories
png("ZF11_13_peak_upset_plot.png", width=1000, height=800)
upsetplot(peakAnno)
dev.off()




# Use narrowPeak file
peakfile <- "macs2/ZF27_neurog2_peaks.narrowPeak"
peaks <- readPeakFile(peakfile)

txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene

# Match coordinate styles (important!)
seqlevelsStyle(peaks) <- "UCSC"

# Annotate peaks
peakAnno <- annotatePeak(peaks,
                         TxDb = txdb,
                         tssRegion = c(-3000, 3000),
                         annoDb = "org.Mm.eg.db")

# Save annotation to CSV
write.csv(as.data.frame(peakAnno),
          file = "ZF27_peaks_annotated_nearby_genes.csv",
          row.names = FALSE)

# Save annotation pie chart
png("ZF27_peak_annotation_piechart.png", width = 800, height = 800)
plotAnnoPie(peakAnno)
dev.off()

# Save distance to TSS plot
png("ZF27_peak_distance_to_TSS.png", width = 800, height = 600)
plotDistToTSS(peakAnno)
dev.off()

# Save UpSet plot
png("ZF27_peak_upset_plot.png", width = 1000, height = 800)
upsetplot(peakAnno)
dev.off()



# Use narrowPeak file
peakfile <- "macs2/ZF17_Rbpj_peaks.narrowPeak"
peaks <- readPeakFile(peakfile)

txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene

# Match coordinate styles (important!)
seqlevelsStyle(peaks) <- "UCSC"

# Annotate peaks
peakAnno <- annotatePeak(peaks,
                         TxDb = txdb,
                         tssRegion = c(-3000, 3000),
                         annoDb = "org.Mm.eg.db")

# Save annotation to CSV
write.csv(as.data.frame(peakAnno),
          file = "ZF17_peaks_annotated_nearby_genes.csv",
          row.names = FALSE)

# Save annotation pie chart
png("ZF17_peak_annotation_piechart.png", width = 800, height = 800)
plotAnnoPie(peakAnno)
dev.off()

# Save distance to TSS plot
png("ZF17_peak_distance_to_TSS.png", width = 800, height = 600)
plotDistToTSS(peakAnno)
dev.off()

# Save UpSet plot
png("ZF17_peak_upset_plot.png", width = 1000, height = 800)
upsetplot(peakAnno)
dev.off()


