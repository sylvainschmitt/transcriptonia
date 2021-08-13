rule samtools_faidx:
    input:
       "data/Sglo_genome_Symcapture.fa",
       "data/Sglo_transcriptome_Transcriptonia.fa"
    output:
       "data/Sglo_genome_Symcapture.fa.fai",
       "data/Sglo_transcriptome_Transcriptonia.fa.fai"
    log:
        "results/logs/samtools_faidx.log"
    benchmark:
        "results/benchmarks/samtools_faidx.benchmark.txt"
    singularity: 
        "oras://registry.forgemia.inra.fr/gafl/singularity/samtools/samtools:latest"
    shell:
        "samtools faidx {input[0]} ; samtools faidx {input[1]}"
        