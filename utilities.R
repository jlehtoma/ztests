library(yaml)

col.as.numeric <- function(x) {
  return(as.numeric(as.character(x)) )
}

get.times <- function(file.name, data) {
  run.name <- basename(file.name)
  run.name <- gsub(".sh", "", run.name)
  run.name <- gsub(".bat", "", run.name)
  
  return(c(run.name, unlist(data[file.name], use.names=FALSE)))
}

differences2df <- function(x) {
  dat <- do.call("rbind", lapply(diffs, function(x) {
                                  c("file1"=basename(x$file1), 
                                    "file2"=basename(x$file2), 
                                    "jaccard.threshold"=x$jaccard[[1]], 
                                    "jaccard.index"=x$jaccard[[2]],
                                    "kendall.tau"=x$kendall_tau[[1]],
                                    "kendall.tau.p"=x$kendall_tau[[2]],
                                    "max"=x$max,
                                    "mean"=x$mean,
                                    "min"=x$min,
                                    "std"=x$std)}
                                )
                )
  dat <- data.frame(dat, stringsAsFactors=FALSE)
  # FIXME: there must be a neater way of doing this...
  dat$jaccard.threshold <- as.numeric(dat$jaccard.threshold)
  dat$jaccard.index <- as.numeric(dat$jaccard.index)
  dat$kendall.tau <- as.numeric(dat$kendall.tau)
  dat$kendall.tau.p <- as.numeric(dat$kendall.tau.p)
  dat$max <- as.numeric(dat$max)
  dat$mean <- as.numeric(dat$mean)
  dat$min <- as.numeric(dat$min)
  dat$std <- as.numeric(dat$std)
  return(dat)
}

times2df <- function(x) {
  
  dat <- yaml.load_file(x)
  
  # Get all keys
  runs <- names(dat)
  # Keep only the bat/sh-paths
  if (any(grepl("^/home.*\\.sh", runs))) {
    pattern <- "^/home.*\\.sh"
  } else {
    pattern <- "*\\.bat"
  }
  runs <- runs[grepl(pattern, runs)]
  
  # Column order is already fixed
  header <- c("run", "cellrem", "elapsed", "init", "measured")
  
  df.dat <- data.frame(do.call("rbind", lapply(runs, get.times, dat)))
  colnames(df.dat) <- header
  # Coerce the numeric columns to really numeric
  df.dat$cellrem <- col.as.numeric(df.dat$cellrem) 
  df.dat$elapsed <- col.as.numeric(df.dat$elapsed)
  df.dat$init <- col.as.numeric(df.dat$init)
  df.dat$measured <- col.as.numeric(df.dat$measured)
  
  # Get the machine information
  df.dat$machine <- paste0(dat$sys_info[[2]]$Uname[[2]], " (", 
                           dat$sys_info[[2]]$Uname[[1]], ")")
  
  return(df.dat)
}