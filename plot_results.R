library(ggplot2)
library(reshape2)
library(yaml)

setwd("/home/jlehtoma/opt/zonation-3.1.9-GNU-Linux/ztests/")

dat.linux <- yaml.load_file("results_linux_x86_64.yaml")
dat.win <- yaml.load_file("results_win7_x86_64.yaml")

# Get all keys
runs.linux <- names(dat.linux)
runs.win <- names(dat.win)
# Keep only the bat-paths
runs.linux <- runs.linux[grepl("^/home.*\\.bat", runs.linux)]
runs.win <- runs.win[grepl("*\\.bat", runs.win)]

times.linux <- c()
times.win <- c()

for (run.linux in runs.linux) {
  run.name.linux <- basename(run.linux)
  times.linux <- c(times.linux, unlist(dat.linux[run.linux]))
  run.win <- runs.win[grepl(run.name.linux, runs.win)]
  run.name.win <- basename(run.win)
  times.win <- c(times.win, unlist(dat.win[run.win]))
}

time.data <- data.frame(run=basename(runs.linux), linux=times.linux, 
                        win=times.win)
# Get rid of do_load.bat, for some reason didn't run well on Win7...
time.data <- time.data[-which(time.data$run == "do_load.bat"),]
# Get rid of do_comm_original_rep.bat, something fishy in Linux...
time.data <- time.data[-which(time.data$run == "do_comm_original_rep.bat"),]

(mean(time.data$linux / time.data$win))

m.time.data <- melt(time.data, variable.name="OS")

p <- ggplot(m.time.data, aes(y=value, x=run, fill=OS)) + 
      geom_bar(position="dodge", stat="identity")
p + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Seconds")

# Without BQP
m.time.data.nobqp <- m.time.data[-which(m.time.data$run == "do_bqp.bat"),]
p <- ggplot(m.time.data.nobqp, aes(y=value, x=run, fill=OS)) + 
  geom_bar(position="dodge", stat="identity")
p + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylab("Seconds")