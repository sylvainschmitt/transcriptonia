## Sylvain SCHMITT
## 08/08/2021

configfile: "config/config.data.yml"

kissfiles, = glob_wildcards(config["kissDEdir"] + "/{kissfile}.fa")

rule all:
    input:
        expand("results/species_specific_snps/{kissfile}.tsv", kissfile=kissfiles)
        
# Rules #

## Species specific ##
include: "rules/kissDE.smk"
