## Sylvain SCHMITT
## 08/08/2021

configfile: "config/config.data.yml"

kissfiles, = glob_wildcards("data/symphonia.trinity500.kissDE/{kissfile}.fa")

rule all:
    input:
        # expand("results/species_specific_snps/{kissfile}.tsv", kissfile=kissfiles),
        # expand("results/environment_specific_snps/{kissfile}.tsv", kissfile=kissfiles),
        "results/ssp3/symcapture.vcf"
        
# Rules #

## Species & environment specific ##
include: "rules/kissDEspecies.smk"
include: "rules/kissDEenv.smk"

## S. sp3 ##
include: "rules/samtools_faidx.smk"
include: "rules/snps2bed.smk"
include: "rules/bedtools_getfasta.smk"
include: "rules/blat.smk"
include: "rules/psl2pos.smk"
include: "rules/bedtools_intersect.smk"
