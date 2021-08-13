rule psl2pos:
    input:
        "results/ssp3/snps.psl",
        "data/k2rt/symphonia_juv_fullsample_trinity500_k2rt_type_0a_mainOutput.tsv"
    output:
        "results/ssp3/snps.tsv",
        "results/ssp3/snps_capture.bed"
    log:
        "results/logs/psl2pos.log"
    benchmark:
        "results/benchmarks/psl2pos.benchmark.txt"
    script:
        "../scripts/psl2pos.R"
        