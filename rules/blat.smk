rule blat:
    input:
       "data/Sglo_genome_Symcapture.fa",
       "results/ssp3/snps.fa"
    output:
        "results/ssp3/snps.psl"
    log:
        "results/logs/blat.log"
    benchmark:
        "results/benchmarks/blat.benchmark.txt"
    shell:
        "~/Tools/blatSrc/bin/blat {input[0]} {input[1]} {output}"
        