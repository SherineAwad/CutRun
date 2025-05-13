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

