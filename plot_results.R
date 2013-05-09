library(ggplot2)
library(reshape2)
library(yaml)


# 1. Setup ----------------------------------------------------------------

setwd("C:/Users/localadmin_jlehtoma/Documents/GitHub/ztests")

dat.linux <- yaml.load_file("results_esmk_linux_x86_64.yaml")
dat.win <- yaml.load_file("results_esmk_win7_x86_64.yaml")


# 2. Read in the data -----------------------------------------------------

# Get all keys
runs.linux <- names(dat.linux)
runs.win <- names(dat.win)
# Keep only the bat-paths
runs.linux <- runs.linux[grepl("^/home.*\\.sh", runs.linux)]
runs.win <- runs.win[grepl("*\\.bat", runs.win)]

get.times <- function(file.name, data) {
  run.name <- basename(file.name)
  run.name <- gsub(".sh", "", run.name)
  run.name <- gsub(".bat", "", run.name)
  
  return(c(run.name, unlist(data[file.name], use.names=FALSE)))
}

col.as.numeric <- function(x) {
  return(as.numeric(as.character(x)) )
}

header <- c("run", "cellrem", "elapsed", "init", "measured")

df.linux <- data.frame(do.call("rbind", lapply(runs.linux, get.times, 
                                               dat.linux)))
colnames(df.linux) <- header
df.linux$cellrem <- col.as.numeric(df.linux$cellrem) 
df.linux$elapsed <- col.as.numeric(df.linux$elapsed)
df.linux$init <- col.as.numeric(df.linux$init)
df.linux$measured <- col.as.numeric(df.linux$measured)

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