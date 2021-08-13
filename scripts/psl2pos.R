tsvin <- snakemake@input[[1]]
psl <-  snakemake@input[[2]]
tsvout <-  snakemake@output[[1]]
bedout <-  snakemake@output[[2]]

# stop("test")
# 
# tsvin <- "results/ssp3/snps_pos0.tsv"
# psl <-  "results/ssp3/snps.psl"
# tsvout <- "results/ssp3/snps.tsv"
# bedout <- "results/ssp3/snps_capture.bed"

library(tidyverse)

alns <- vroom::vroom(psl, skip = 5, 
                     col_names = c("matches", "misMatches", "repMatches", "nCount", 
                                   "qNumInsert", "qBaseInsert",
                                   "tNumInsert", "tBaseInsert", "strand", 
                                   "qName", "qSize", "qStart", "qEnd", 
                                   "tName", "tSize", "tStart", "tEnd", 
                                   "blockCount", "blockSizes", "qStarts", "tStarts"), 
                     col_types = cols(blockSizes = col_character(), tStarts = col_character())) %>% 
  rename(snp = qName) %>% 
  left_join(vroom::vroom(tsvin)) %>% 
  mutate(snp_pos = pos0+1) %>% 
  filter(qStart <= snp_pos, qEnd >= snp_pos) %>% 
  group_by(snp) %>% 
  filter(matches == max(matches)) %>% 
  sample_n(1) %>% 
  separate_rows(blockSizes, qStarts, tStarts, sep = ",", convert = T) %>% 
  filter(!is.na(qStarts)) %>% 
  filter(qStarts <= snp_pos) %>% 
  mutate(posSNP = tStarts + snp_pos - qStarts) %>% 
  mutate(tEnd = tStarts + blockSizes) %>% 
  filter(posSNP <= tEnd) %>% 
  dplyr::select(tName, snp, posSNP) %>% 
  dplyr::rename(pos = posSNP, scf = tName) %>% 
  unique() %>% 
  group_by(snp) %>% 
  sample_n(1)

write_tsv(alns, tsvout)
alns %>% 
  mutate(start = max(1, pos-2), stop = pos+2) %>% 
  select(snp, start, stop) %>% 
  write_tsv(bedout, col_names = F)
