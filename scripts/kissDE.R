infile <- snakemake@input[[1]]
outfile <-  snakemake@output[[1]] 

# infile <- "data/symphonia.trinity500.kissDE/results_reduced_type_0a.fa"
# outfile <- "results/species_specific_snps/results_reduced_type_0a.tsv"

library(kissDE)

conditions <- c(rep("glo",14), 
                rep("sp1", 23)) # species
counts <- kissplice2counts(
  infile,
  pairedEnd = T
)
dev <- diffExpressedVariants(
  counts$countsEvents, 
  conditions, 
  filterLowCountsVariants = 100, # kissplice2counts parameter
  pvalue = 0.001 # kissplice2counts parameter
)
writeOutputKissDE(dev, outfile)
