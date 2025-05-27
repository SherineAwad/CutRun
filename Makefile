SAMPLES = $(shell cat reSamples.tsv)

BAMS = $(addsuffix .bam, $(SAMPLES))
STATS = $(addsuffix _stats.txt, $(SAMPLES))

flagstats: $(STATS)

%_stats.txt: %.bam
	samtools flagstat $< > $@



FILES1 = 13186-ZF-9_R1.fastq.gz 13186-ZF-11_R1.fastq.gz 13186-ZF-12_R1.fastq.gz 13186-ZF-13_R1.fastq.gz 13186-ZF-14_R1.fastq.gz 13186-ZF-15_R1.fastq.gz 13186-ZF-16_R1.fastq.gz 13186-ZF-17_R1.fastq.gz 13186-ZF-27_R1.fastq.gz 13186-ZF-28_R1.fastq.gz


FILES2 = 13186-ZF-29_R1.fastq.gz 13186-ZF-30_R1.fastq.gz 13186-ZF-31_R1.fastq.gz 13186-ZF-32_R1.fastq.gz 13186-ZF-33_R1.fastq.gz 13186-ZF-34_R1.fastq.gz 13186-ZF-18_R1.fastq.gz

FILES3 = 13186-ZF-19_R1.fastq.gz 13186-ZF-20_R1.fastq.gz	13186-ZF-21_R1.fastq.gz 13186-ZF-22_R1.fastq.gz 13186-ZF-23_R1.fastq.gz 13186-ZF-24_R1.fastq.gz 13186-ZF-25_R1.fastq.gz 13186-ZF-26_R1.fastq.gz

fastq_screen_all:
	for file in $(FILES3); do \
		perl ../tools/fastq_screen_v0.13.0/fastq_screen --conf ../tools/fastq_screen_v0.13.0/fastq_screen.conf $$file --aligner bowtie2; \
	done



macs_broad/ZF14_Rb_H3K27me3_broad_peaks.broadPeak:

	macs2 callpeak -t ZF14_Rb_H3K27me3.sorted.rmDup.bam -f BAMPE -g mm --outdir macs_broad --broad  -n ZF14_Rb_H3K27me3_broad


MotifB_ZF14_Rb_H3K27me3/knownResults.html: 
	findMotifsGenome.pl macs_broad/ZF14_Rb_H3K27me3_broad_peaks.broadPeak ../REFERENCES/Mus_musculus/Ensembl/GRCm38/Sequence/WholeGenomeFasta/genome.fa MotifB_ZF14_Rb_H3K27me3 -size 200 -mask





macs2/ZF17_Rbpj_top5000_peaks.narrowPeak:
	awk 'BEGIN{OFS="\t"} {print $0}' macs2/ZF17_Rbpj_peaks.narrowPeak | sort -k7,7nr | head -n 5000 > macs2/ZF17_Rbpj_top5000_peaks.narrowPeak

Motif_ZF17_Rbpj_top5k/knownResults.html:
	findMotifsGenome.pl macs2/ZF17_Rbpj_top5000_peaks.narrowPeak ../REFERENCES/Mus_musculus/Ensembl/GRCm38/Sequence/WholeGenomeFasta/genome.fa Motif_ZF17_Rbpj_top5k/ -size 200 -mask


Motif_ZF17_Rbpj2/knownResults.html:
	findMotifsGenome.pl macs2/ZF17_Rbpj_peaks.narrowPeak ../REFERENCES/Mus_musculus/Ensembl/GRCm38/Sequence/WholeGenomeFasta/genome.fa  Motif_ZF17_Rbpj2 -size 75 -mask

Motif_ZF17_Rbpj3: 
	findMotifsGenome.pl macs2/ZF17_Rbpj_peaks.narrowPeak ../REFERENCES/Mus_musculus/Ensembl/GRCm38/Sequence/WholeGenomeFasta/genome.fa Motif_ZF17_Rbpj3 -size 200 -mask -flip

Motif_ZF17_Rbpj4:
	findMotifsGenome.pl macs2/ZF17_Rbpj_peaks.narrowPeak ../REFERENCES/Mus_musculus/Ensembl/GRCm38/Sequence/WholeGenomeFasta/genome.fa Motif_ZF17_Rbpj4  -find /nfs/turbo/umms-thahoang/sherine/miniconda/envs/archr/share/homer/motifs/rbpj1.motif > rbpj_hits.txt


#Trying SEACR
ZF17_Rbpj.bedgraph:
	bigWigToBedGraph ZF17_Rbpj.bigwig ZF17_Rbpj.bedgraph

ZF17_Rbpj.bed:
	bash SEACR_1.3.sh ZF17_Rbpj.bedgraph 0.01 non stringent ZF17_Rbpj

#-f 0.5: Requires at least 50% of a region in -a to overlap a region in -b.
#-r: Requires that the reciprocal condition is met — i.e., both regions must overlap each other by at least 50%.
#https://macs3-project.github.io/MACS/docs/narrowPeak.html#
#https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html
ZF11_ZF13.bed:
	bedtools intersect -a macs2/ZF11_Nfiabx_peaks.narrowPeak -b macs2/ZF13_Nfiabx_peaks.narrowPeak  -f 0.5 -r > ZF11_ZF13.bed 


ZF11_13_peaks_annotated_nearby_genes.csv:
	Rscript nearbyGenes.R


Motif_ZF11_ZF13_shared_peaks/knownResults.html:
	findMotifsGenome.pl ZF11_ZF13.bed ../REFERENCES/Mus_musculus/Ensembl/GRCm38/Sequence/WholeGenomeFasta/genome.fa  Motif_ZF11_ZF13_shared_peaks -size 200 -mask
