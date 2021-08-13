tsv <- snakemake@input[[1]]
ref <- snakemake@input[[2]]
bed <-  snakemake@output[[1]]
pos <-  snakemake@output[[2]]

# tsv <- "data/k2rt/symphonia_juv_fullsample_trinity500_k2rt_type_0a_mainOutput.tsv"
# ref <- "data/Sglo_transcriptome_Transcriptonia.fa.fai"
# bed <- "results/ssp3/snps.bed"
# pos <-  "results/ssp3/snps_pos0.tsv"

library(tidyverse)

ref <- read_tsv(ref, col_names = c("trsc", "length"))
N <- 500
snps <- vroom::vroom(tsv) %>% 
  filter(Possible_sequencing_error != "True") %>% 
  filter(SNP_in_mutliple_assembled_genes != "True") %>% 
  dplyr::rename(trsc = `#Component_ID`, snp = SNP_ID, pos = SNP_position) %>% 
  dplyr::select(trsc, snp, pos) %>% 
  filter(!is.na(pos)) %>% 
  filter(trsc %in% ref$trsc) %>% 
  left_join(ref) %>% 
  rowwise() %>% 
  mutate(start = max(pos - N-1, 1), stop = min(pos + N, length), 
         pos0 = ifelse((pos - N-1) < 0, 500 + pos - N-1, 500))
select(snps, trsc, start, stop) %>% 
  write_tsv(bed, col_names = F)
select(snps, snp, trsc, pos0) %>% 
  write_tsv(pos, col_names = T)

# library(Biostrings)
# snps <- read_tsv(pos)
# fa <- readDNAStringSet("results/ssp3/snps.fa")
# names(fa) <- snps$snp
# writeXStringSet(fa, filepath = "results/ssp3/snps.fa")
