library(ABSOLUTE)
source("/ifshk7/BC_PS/yangchao/software/ABSOLUTE/V1.2/ABSOLUTEv1.2/why_source.R")

d <- read.table('absolute.files.txt',header=FALSE,stringsAsFactors=FALSE)

absolute.files <- d$V1
selected.model.ix <- as.numeric(d$V2)
samples <- sub('.ABSOLUTE.RData','',basename(absolute.files))
names(selected.model.ix) <- samples
obj.name<-"ccRCC"
RESULTS_DIR<- paste("ABSOLUTE_results",obj.name,sep = "/")
copy_num_type<-"allelic"
plot.mode.review<-FALSE

if( !file.exists(RESULTS_DIR)) {
         dir.create(RESULTS_DIR, recursive=TRUE, showWarnings=FALSE)
      }

nm = file.path(RESULTS_DIR, paste(obj.name, ".PP-modes", sep = ""))
modesegs.fn = paste(nm, ".data.RData", sep = "")
failed.pdf.fn = paste(nm, "FAILED_plots.pdf", sep = ".")
failed.tab.fn = paste(nm, "FAILED_tab.txt", sep = ".")
call.tab.fn = file.path(RESULTS_DIR, paste(obj.name, "PP-calls_tab.txt", sep = "."))

agg_res = CreateReviewObject( obj.name, absolute.files, copy_num_type, plot.modes=TRUE, plot.mode.review=plot.mode.review,num_solutions_plotted=selected.model.ix, verbose=TRUE)
segobj.list = agg_res[["segobj.list"]]
save(segobj.list, file = modesegs.fn)
PrintPpCallTable(segobj.list, call.tab.fn)

d <- read.table(call.tab.fn, header=TRUE, stringsAsFactors=FALSE, sep="\t")
ix <- selected.model.ix[d$sample]
d <- cbind(ix, d)
colnames(d)[1] = "override"
reviewed.pp.calls.fn <- paste(RESULTS_DIR,'man_review.txt', sep = "/")
write.table(d, file=reviewed.pp.calls.fn, quote=FALSE, sep="\t", row.names=FALSE)

if( plot.mode.review ) {
         pdf.fn = paste(nm, ".dens.mode-review.plots.pdf", sep = "")
         pdf(pdf.fn, 17.5, 18.5 )
         cat( paste("Plotting mode-review summary for ", length(segobj.list), " samples", sep="") )
         for( i in 1:length(segobj.list) )
         {
            PlotModes_layout()
            PlotModes(segobj.list[[i]], n.print=4)
            cat(".")
         }
         dev.off()
         cat("done.\n")
}


if (!is.null( agg_res[["failed.list"]][[1]])){
         try( PlotFailedSamples(agg_res[["failed.list"]], failed.pdf.fn) )
         PrintFailedTable(agg_res[["failed.list"]], failed.tab.fn)
}
rm(segobj.list)

extract_name = paste(obj.name,"extract",sep = ".")
apply_review_and_extract(pp.review.fn=reviewed.pp.calls.fn, obj.name=obj.name, analyst.id="ccRCC", copy_num_type="allelic"  )
