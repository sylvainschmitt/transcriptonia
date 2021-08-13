rule kissDEspecies:
    input:
        "data/symphonia.trinity500.kissDE/{kissfile}.fa"
    output:
        "results/species_specific_snps/{kissfile}.tsv"
    log:
        "results/logs/kissDEspecies_{kissfile}.log"
    benchmark:
        "results/benchmarks/kissDEspecies_{kissfile}.benchmark.txt"
    script:
        "../scripts/kissDEspecies.R"
        