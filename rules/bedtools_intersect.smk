rule bedtools_intersect:
    input:
        "data/symcapture.all.biallelic.snp.filtered.nonmissing.paracou.vcf",
        "results/ssp3/snps_capture.bed"
    output:
        "results/ssp3/symcapture.vcf"
    log:
        "results/logs/bedtools_intersect.log"
    benchmark:
        "results/benchmarks/bedtools_intersect.benchmark.txt"
    singularity: 
        "oras://registry.forgemia.inra.fr/gafl/singularity/bedtools/bedtools:latest"
    shell:
        "bedtools intersect -header -wa -a {input[0]} -b {input[1]} > {output}"
        