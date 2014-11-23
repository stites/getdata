dl <- function (url, short){
  linkPartials <- strsplit(url, "\\.")
  filetype <- as.character(tail(data.frame(linkPartials[[1]]),1)[[1]])
  destfilename <- paste("./",short,'.', filetype, sep="")
  download.file(url, destfile=destfilename, method="curl")
  destfilename
}