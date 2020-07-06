# combine rwl data from multiple files
# clear environment
library(dplR)
library(data.table)
library(tcltk)
file_location <- tk_choose.dir()
file_names <- dir(file_location, pattern =".rwl")
setwd(file_location)
errordir <- file.path(file_location,"errors")
dir.create(errordir,showWarnings = FALSE)

for(i in 1:length(file_names)) {
  treeringseries <- try(read.tucson(file_names[i],header=TRUE,long=TRUE))
  if (class(treeringseries)=="try-error"){
    file.rename(file_names[i],file.path(errordir, file_names[i]))
  } else {
    if (exists("tr_all")){
      tr_all <- combine.rwl(treeringseries, tr_all)
      # combine.rwl adds each new rwl to the left, therefore the same in this list
      series_list <- rbind(data.frame(rep(file_names[i],ncol(treeringseries)),colnames(treeringseries)),series_list)
    } else {
      tr_all <- treeringseries
      series_list <- data.frame(rep(file_names[i],ncol(treeringseries)),colnames(treeringseries))
    }
  }
}

# export series to rwl
correct_series_path <- file.path(file_location,"all_correct_series")
dir.create(correct_series_path,showWarnings = FALSE)
exportfile = file.path(correct_series_path,"usa.rwl")
write.rwl(tr_all, exportfile, format = c("tucson"))
# rename all series with code for continent and number (af,as,eu,us,mx,ca,sa)
# following by lettercombination starting with A to ZZZZ
# maximal ID-lenght in rwl = 6
# if more then 450000 tree rings the ID will be longer than 6 chars
# source for char array: https://stackoverflow.com/questions/39731762/convert-sequence-of-integers-1-2-3-to-corresponding-sequence-of-strings-a/39780158
n  <- length(tr_all)
sz  <- ceiling(log(n)/log(26))
charlist <- do.call(CJ, replicate(sz, c("", LETTERS), simplify = F))[-1, unique(Reduce(paste0, .SD))][1:n]
# choose code for continent and number (af,as,eu,us,mx,ca,sa)
colnames(tr_all) <- sprintf("us%s", charlist)
exportfile_renamed = file.path(correct_series_path,"us_ren.rwl")
write.rwl(tr_all, exportfile_renamed, format = c("tucson"))

series_list <- cbind(series_list,colnames(tr_all))
colnames(series_list) <- c("filename","name_original","name_new")
write.csv(series_list,file.path("us_names.csv"),row.names = FALSE)
