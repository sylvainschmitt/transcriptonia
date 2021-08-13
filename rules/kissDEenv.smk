rule kissDEenv:
    input:
        "data/symphonia.trinity500.kissDE/{kissfile}.fa",
        "data/symphonia.trinity500.kissDE/juvRNAlibrariesDistributions.txt"
    output:
        "results/environment_specific_snps/{kissfile}.tsv"
    log:
        "results/logs/kissDEenv_{kissfile}.log"
    benchmark:
        "results/benchmarks/kissDEenv_{kissfile}.benchmark.txt"
    script:
        "../scripts/kissDEenv.R"
        