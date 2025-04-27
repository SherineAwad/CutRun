SAMPLES = $(shell cat reSamples.tsv)

BAMS = $(addsuffix .bam, $(SAMPLES))
STATS = $(addsuffix _stats.txt, $(SAMPLES))

flagstats: $(STATS)

%_stats.txt: %.bam
	samtools flagstat $< > $@

