rule kissDEspecies:
    input:
        expand("{dir}/{kissfile}.fa", dir=config["kissDEdir"], allow_missing=True)
    output:
        "results/species_specific_snps/{kissfile}.tsv"
    log:
        "results/logs/kissDEspecies_{kissfile}.log"
    benchmark:
        "results/benchmarks/kissDEspecies_{kissfile}.benchmark.txt"
    script:
        "../scripts/kissDEspecies.R"
        