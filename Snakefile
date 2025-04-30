with open(config['SAMPLES']) as fp:
    samples = fp.read().splitlines()

print(samples)

with open(config['reSAMPLES']) as fp:
    reSamples = fp.read().splitlines()
print(reSamples)

rule all:
         input:
            #Prepare samples
            #================
            #expand("galore/{sample}_R1_val_1.fq.gz", sample=samples),
            #expand("galore/{sample}_R2_val_2.fq.gz", sample=samples),
            expand("{sample}.sam", sample = samples),
            expand("{sample}.sam", sample = reSamples),
            expand("{sample}.bam", sample = reSamples), 
            expand("{sample}.sorted.bam", sample =reSamples),
            expand("{sample}.sorted.rmDup.bam", sample =reSamples),
            expand("{sample}.bigwig", sample = reSamples),
            expand("macs2_nolambda/{sample}_peaks.narrowPeak", sample=reSamples), 
	    expand("macs2_nolambda/{sample}_summits.bed", sample=reSamples),
            expand("MotifNL_{sample}/seq.autonorm.tsv", sample=reSamples),
rule trim: 
       input: 
           r1 = "{sample}_R1.fastq.gz",
           r2 = "{sample}_R2.fastq.gz"
       output:
           "galore/{sample}_R1_val_1.fq.gz",
           "galore/{sample}_R2_val_2.fq.gz"
       shell: 
           """
           mkdir -p galore 
           mkdir -p fastqc 
           trim_galore --gzip --retain_unpaired --fastqc --fastqc_args "--outdir fastqc" -o galore --paired {input.r1} {input.r2}
           """ 
rule align:
              input:               
                    "galore/{sample}_R1_val_1.fq.gz",
                    "galore/{sample}_R2_val_2.fq.gz"
              params:
                   index=config['INDEX'],
                   mem = config['MEMORY'],
                   cores = config['CORES']
              output:
                   "{sample}.sam",
                   "{sample}_hist.txt" 
              shell:
                   """
                   bowtie2 --local --very-sensitive-local --no-mixed --no-discordant --phred33 -I 10 -X 700 -p {params.cores} -x {params.index} -1 {input[0]} -2 {input[1]} -S {output[0]}  &> {output[1]}
                   """
rule rename: 
        input: 
	    "{sample}.sam"          
        output: 
            expand("{sample}.sam", sample = reSamples)
        shell: 
            "bash rename.sh" 



rule samTobam:
             input: 
                 "{sample}.sam",
             output: 
                 "{sample}.bam"
             shell: 
                   """
                   samtools view -bS {input} > {output}
                   """


rule sort: 
             input: 
                  "{sample}.bam"
             output: 
                    "{sample}.sorted.bam"
             shell: 
                   """ 
                   picard SortSam I={input}  O={output} SORT_ORDER=coordinate 
                   """ 

rule remove_duplicates:
       input: 
        "{sample}.sorted.bam"
       output: 
         "{sample}.sorted.rmDup.bam",
         "{sample}.rmDup.txt"
       shell: 
           """
            picard MarkDuplicates I={input} O={output[0]} REMOVE_DUPLICATES=true METRICS_FILE={output[1]} 
           """

rule index: 
      input: 
         "{sample}.sorted.rmDup.bam"
      output: 
         "{sample}.sorted.rmDup.bam.bai"
      shell: 
          """
          samtools index {input} 
          """ 

#Note --nolambda 
rule macs2: 
    input:
        lambda wildcards: f"{wildcards.sample}.sorted.rmDup.bam"
    output:
        "macs2_nolambda/{sample}_peaks.narrowPeak", 
        "macs2_nolambda/{sample}_summits.bed"
    params:
        outdir = "macs2_nolambda",
        genome = "mm"
    shell:
        """
        macs2 callpeak -t {input} -f BAMPE -g {params.genome} --nolambda  --outdir {params.outdir} -n {wildcards.sample}
        """


rule annotateNarrowPeaks: 
      input: 
         "macs/{sample}_peaks.narrowPeak" 
      params: 
           genome= config['GENOME'], 
           gtf = config['GTF']  
      output: 
         "{sample}.annotatednarrowpeaks", 
         "{sample}.annotatednarrowpeaks.stats"
      shell: 
          """
          annotatePeaks.pl {input} {params.genome} -gtf {params.gtf}   -annStats {output[1]}  > {output[0]}    
          """ 


rule findMotifs:
      input:
          "macs2_nolambda/{sample}_summits.bed"
      params:
          genome = config['GENOME'],
          output_dir = "MotifNL_{sample}"
      output:
          "MotifNL_{sample}/seq.autonorm.tsv"
      shell:
         """
          findMotifsGenome.pl {input} {params.genome} {params.output_dir} -size 200 -mask
         """


