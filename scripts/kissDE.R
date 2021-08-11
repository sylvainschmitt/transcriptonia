infile <- snakemake@input[[1]]
outfile <-  snakemake@output[[1]] 

library(kissDE)
library(tidyverse

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
dev$finalTable %>% 
  dplyr::rename(snp = ID, length_diff = Length_diff, 
                pvalue = Adjusted_pvalue, dfdpsi = `Deltaf/DeltaPSI`) %>% 
  reshape2::melt(c("snp", "length_diff", "pvalue", "dfdpsi", "lowcounts"),
                 variable.name = "variant", value.name = "count") %>% 
  separate(variant, c("variant", "species", "individual", "norm")) %>% 
  dplyr::select(-norm) %>% 
  mutate(species = recode(species, "glo" = "S. globulifera", "sp1" = "S. sp.1")) %>% 
  vroom::vroom_write(outfile)
