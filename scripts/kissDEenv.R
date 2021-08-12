infile <- snakemake@input[[1]]
conditions <- snakemake@input[[2]]
outfile <-  snakemake@output[[1]] 

# infile <- "data/symphonia.trinity500.kissDE/results_coherent_type_2.fa"
# conditions <- "data/symphonia.trinity500.kissDE/juvRNAlibrariesDistributions.txt"

library(kissDE)
library(tidyverse)

conditions <- read_tsv(conditions)$habitat

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

dev$finalTable %>% 
  dplyr::rename(snp = ID, length_diff = Length_diff, 
                pvalue = Adjusted_pvalue, dfdpsi = `Deltaf/DeltaPSI`) %>% 
  reshape2::melt(c("snp", "length_diff", "pvalue", "dfdpsi", "lowcounts"),
                 variable.name = "variant", value.name = "count") %>% 
  separate(variant, c("variant", "habitat", "individual", "norm")) %>% 
  dplyr::select(-norm) %>% 
  mutate(species = recode(habitat, "HT" = "hilltops", "SF" = "seasonally-flooded")) %>% 
  vroom::vroom_write(outfile)
