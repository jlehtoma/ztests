library(ggplot2)
library(reshape2)
library(yaml)


# 1. Setup ----------------------------------------------------------------

setwd("C:/Users/localadmin_jlehtoma/Documents/GitHub/ztests")

dat.win <- yaml.load_file("results_esmk_win7_x86_64.yaml")


# 2. Read in the data -----------------------------------------------------

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
  if (grepl("^/home.*\\.sh")) {
    pattern <- "^/home.*\\.sh"
  } else {
    pattern <- "*\\.bat"
  }
  runs <- runs[grepl(pattern, runs)]
  
  header <- c("run", "cellrem", "elapsed", "init", "measured")
  
  df.dat <- data.frame(do.call("rbind", lapply(runs, get.times, dat)))
  colnames(df.dat) <- header
  df.dat$cellrem <- col.as.numeric(df.dat$cellrem) 
  df.dat$elapsed <- col.as.numeric(df.dat$elapsed)
  df.dat$init <- col.as.numeric(df.dat$init)
  df.dat$measured <- col.as.numeric(df.dat$measured)
  
  return(df.dat)
}

df.linux.mrgsite25 <- yaml2df("results_esmk_linux_x86_64.yaml")
df.win.mrgtesla <- yaml2df("results_esmk_linux_x86_64.yaml")

#df.win <- data.frame(do.call("rbind", lapply(runs.win, get.times, dat.win)))
#colnames(df.win) <- header


# 3. Stats ----------------------------------------------------------------

(mean(time.data$linux / time.data$win))


# 4. Plotting -------------------------------------------------------------


# 4.1 Total elapsed time --------------------------------------------------

# Linux
p <- ggplot(df.linux, aes(y=elapsed, x=run)) + 
     geom_bar(position="dodge", stat="identity")
p + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + ylab("Seconds") 

p <- ggplot(df.linux, aes(y=init, x=run)) + 
  geom_bar(position="dodge", stat="identity")
p + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + ylab("Seconds")

# 4.2 Per stage -----------------------------------------------------------



m.time.data <- melt(time.data, variable.name="OS")

p <- ggplot(m.time.data, aes(y=value, x=run, fill=OS)) + 
      geom_bar(position="dodge", stat="identity")
p + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Seconds")

# Without BQP
m.time.data.nobqp <- m.time.data[-which(m.time.data$run == "do_bqp.bat"),]
p <- ggplot(m.time.data.nobqp, aes(y=value, x=run, fill=OS)) + 
  geom_bar(position="dodge", stat="identity")
p + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Seconds")