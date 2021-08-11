infile <- snakemake@input[[1]]
outfile <-  snakemake@output[[1]] 

infile <- "data/symphonia.trinity500.kissDE.reduced/results_reduced_type_1.fa"

library(kissDE)

conditions <- c(rep("glo",14), 
                rep("sp1", 23)) # species
counts <- kissplice2counts(
  infile,
  counts = 0,
  pairedEnd = T
)
dev <- diffExpressedVariants(
  counts$countsEvents, 
  conditions, 
  filterLowCountsVariants = 100, # kissplice2counts parameter
  pvalue = 0.001 # kissplice2counts parameter
)
writeOutputKissDE(dev, outfile)
