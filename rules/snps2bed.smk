rule snps2bed:
    input:
        "data/k2rt/symphonia_juv_fullsample_trinity500_k2rt_type_0a_mainOutput.tsv",
        "data/Sglo_transcriptome_Transcriptonia.fa.fai"
    output:
        "results/ssp3/snps.bed",
        "results/ssp3/snps_pos0.tsv"
    log:
        "results/logs/snps2bed.log"
    benchmark:
        "results/benchmarks/snps2bed.benchmark.txt"
    script:
        "../scripts/snps2bed.R"
        