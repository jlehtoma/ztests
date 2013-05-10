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

yaml2df <- function(x) {
  
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