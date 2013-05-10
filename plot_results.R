library(ggplot2)
library(reshape2)
library(yaml)

# Helper functions --------------------------------------------------------

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

# 1. Setup ----------------------------------------------------------------

setwd("C:/Users/localadmin_jlehtoma/Documents/GitHub/ztests")

# 2. Read in the data -----------------------------------------------------

df.linux.mrgsite25 <- yaml2df("results_esmk_linux_x86_64.yaml")
df.win.mrgsite25 <- yaml2df("results_esmk_win_MRGSITE25_x86_64.yaml")
df.win.mrgtesla <- yaml2df("results_esmk_win_MRGTESLA_x86_64.yaml")

# Fix the machine names for Linux
df.linux.mrgsite25$machine <- "LH2-BIOTI25 (Linux)"

# Merge all data
df.dat <- rbind(df.linux.mrgsite25, df.win.mrgsite25, df.win.mrgtesla)

# 3. Stats ----------------------------------------------------------------

(df.linux.mrgsite25$elapsed / df.win.mrgsite25$elapsed)
(mean(df.win.mrgsite25$elapsed / df.linux.mrgsite25$elapsed))
(sd(df.linux.mrgsite25$elapsed / df.win.mrgsite25$elapsed))

# 4. Plotting -------------------------------------------------------------

# 4.1 Total elapsed time --------------------------------------------------

p <- ggplot(df.dat, aes(y=elapsed, x=run, fill=machine)) + 
     geom_bar(position="dodge", stat="identity")
p + theme(axis.text.x = element_text(size=18)) + ylab("Seconds") + xlab("Run") +
  scale_x_discrete(labels=c(15:20)) + ggtitle("Total elapsed time")

# 4.2 Init -----------------------------------------------------------

p <- ggplot(df.dat, aes(y=init, x=run, fill=machine)) + 
  geom_bar(position="dodge", stat="identity")
p + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + ylab("Seconds") +
  ggtitle("Initiation stage")
