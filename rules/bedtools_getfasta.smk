rule bedtools_getfasta:
    input:
        "data/Sglo_transcriptome_Transcriptonia.fa",
        "results/ssp3/snps.bed"
    output:
        "results/ssp3/snps.fa"
    log:
        "results/logs/bedtools_getfasta.log"
    benchmark:
        "results/benchmarks/bedtools_getfasta.benchmark.txt"
    singularity: 
        "oras://registry.forgemia.inra.fr/gafl/singularity/bedtools/bedtools:latest"
    shell:
        "bedtools getfasta -fi {input[0]} -bed {input[1]} -fo {output}"
        