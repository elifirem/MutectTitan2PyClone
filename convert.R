#!/usr/bin/Rscript

library(splitstackshape)

MutectTitan2PyClone <- function(variants, copynum, sample.id, norm.cn = 2) {
  variants <- cbind(variants[,c(1, 2, 14)], MajorCN = as.numeric(NA), MinorCN = as.numeric(NA))#selects CHROM, POS, AD columns 
  variants[,3] <- sub("^([^,]*,[^,]*),.*$", "\\1", variants[,3])
  variants <- cSplit(variants, 3, ",") #only takes the first alt_allele on a multiallelic site and ignores the rest
  colnames(variants) <- c("chromosome", "position", "MajorCN", "MinorCN", "ref", "alt")
  for (i in 1:nrow(copynum)) {
    pos.filt <- variants$chromosome == copynum$Chromosome[i] & variants$position >= copynum$Start_Position.bp.[i] & variants$position <= copynum$End_Position.bp.[i]
    variants[pos.filt, c("MajorCN", "MinorCN")] <- copynum[i, c("MajorCN", "MinorCN")]
  }
  id          <- paste(sample.id, variants$chromosome, variants$position, sep = ':')
  pyclone.tsv <- data.frame(mutation_id = id, ref_counts = variants$ref, var_counts = variants$alt,
                            normal_cn = norm.cn,	minor_cn = variants$MinorCN, major_cn = variants$MajorCN,
                            variant_case = sample.id)
  na.exclude(pyclone.tsv)
}


args <- commandArgs(TRUE)
variants <- read.delim((args[1]), header = TRUE, sep = "\t")
copynum <- read.delim((args[2]), header = TRUE, sep = "\t")
sample.id <- (args[3])
out.id <- paste(sample.id, 'tsv', sep = '.')

input_pyclone <- MutectTitan2PyClone(variants, copynum, sample.id, norm.cn = 2)
write.table(input_pyclone, file=out.id, quote=FALSE, sep='\t', row.names = FALSE)
