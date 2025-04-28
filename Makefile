SAMPLES = $(shell cat reSamples.tsv)

BAMS = $(addsuffix .bam, $(SAMPLES))
STATS = $(addsuffix _stats.txt, $(SAMPLES))

flagstats: $(STATS)

%_stats.txt: %.bam
	samtools flagstat $< > $@



FILES = 13186-ZF-9_R1.fastq.gz 13186-ZF-11_R1.fastq.gz 13186-ZF-12_R1.fastq.gz 13186-ZF-13_R1.fastq.gz 13186-ZF-14_R1.fastq.gz 13186-ZF-15_R1.fastq.gz 13186-ZF-16_R1.fastq.gz 13186-ZF-17_R1.fastq.gz 13186-ZF-27_R1.fastq.gz 13186-ZF-28_R1.fastq.gz

fastq_screen_all:
	for file in $(FILES); do \
		perl ../tools/fastq_screen_v0.13.0/fastq_screen --conf ../tools/fastq_screen_v0.13.0/fastq_screen.conf $$file --aligner bowtie2; \
	done


