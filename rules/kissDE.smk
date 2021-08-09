rule kissDE:
    input:
        expand("{dir}/{kissfile}.fa", dir=config["kissDEdir"], allow_missing=True)
    output:
        "results/species_specific_snps/{kissfile}.tsv"
    log:
        "results/logs/kissDE_{kissfile}.log"
    benchmark:
        "results/benchmarks/kissDE_{kissfile}.benchmark.txt"
    script:
        "../scripts/kissDE.R"
        