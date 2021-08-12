rule kissDEenv:
    input:
        expand("{dir}/{kissfile}.fa", dir=config["kissDEdir"], allow_missing=True),
        expand("{dir}/juvRNAlibrariesDistributions.txt", dir=config["kissDEdir"])
    output:
        "results/environment_specific_snps/{kissfile}.tsv"
    log:
        "results/logs/kissDEenv_{kissfile}.log"
    benchmark:
        "results/benchmarks/kissDEenv_{kissfile}.benchmark.txt"
    script:
        "../scripts/kissDEenv.R"
        