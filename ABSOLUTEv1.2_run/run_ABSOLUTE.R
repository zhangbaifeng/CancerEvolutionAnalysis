#!/ifshk4/BC_PUB/biosoft/PIPE_RD/Package/R-3.1.1/bin/Rscript

args <- commandArgs(TRUE)

seg.dat.fn <- args[1]
maf.fn <- args[2]
indel.maf.fn <- args[3]
#SSNV_skew <- args[4] 
results.dir <- args[4]
sample.name <- args[5]
primary.disease <- args[6]
#############################

#seg.dat.fn <- '/ifshk4/BC_CANCER/PROJECT/HKC11045_HUMxfnX_EC/zhouyong/GC/absolute/AllelicCapseq_v1.0.14.6/GastricCancer_GC089/GC089.tsv'
#maf.fn <- '/ifshk7/BC_PS/yangchao/software/Oncotator/test/YJGC-34T.snv.maf'
#indel.maf.fn <-NA
#SSNV_skew <- "/ifshk7/BC_PS/yangchao/software/AllelicCapseg/test/results_steps/results/HCC1143.skew"
#results.dir <- '/ifshk7/BC_PS/yangchao/software/ABSOLUTE/V1.2/ABSOLUTEv1.2/GC089/'
#sample.name <- 'GC089'
#primary.disease <- 'Esophageal squamous'

##############################
primary.disease <- primary.disease
#copy_num_type <- 'total'
copy_num_type <- 'allelic'
max.as.seg.count <- 1500#30550
min.mut.af <- 0.0
platform <- 'Illumina_WES'
genome_build <- 'hg19'
min.ploidy=0.95#1.5
max.ploidy=6#6
max.non.clonal=0.9#0
max.neg.genome=0.05#0
min_probes=10
max_sd=100
sigma.h=0.01
output.fn.base=sample.name
filter_segs = TRUE
force.alpha=NA
force.tau=NA
verbose=TRUE
SSNV_skew=1

##############################

library(ABSOLUTE)
#source("/ifshk7/BC_PS/yangchao/software/ABSOLUTE/V1.2/ABSOLUTEv1.2/ABSOLUTE2/R/ABSOLUTE_result_plot.R")
#source("/Users/baifeng/Desktop/BGIproject/ccRCC/ABSOLUTEv1.2/library/R/ABSOLUTE_result_plot.R")
RunAbsolute(seg.dat.fn, maf.fn=maf.fn, indel.maf.fn=indel.maf.fn,results.dir=results.dir,sample.name=sample.name, primary.disease=primary.disease, genome_build=genome_build,copy_num_type=copy_num_type,min.ploidy=min.ploidy,max.ploidy=max.ploidy,platform=platform,max.as.seg.count=max.as.seg.count, min.mut.af=min.mut.af,max.non.clonal=max.non.clonal, max.neg.genome=max.neg.genome, min_probes=min_probes, max_sd=max_sd, sigma.h=sigma.h, output.fn.base=output.fn.base, filter_segs =filter_segs, SSNV_skew=1, verbose=TRUE, force.alpha=NA, force.tau=NA)
