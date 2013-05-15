library(ggplot2)
library(reshape2)
library(yaml)

source("utilities.R")

# 1. Setup ----------------------------------------------------------------

setwd("C:/Users/localadmin_jlehtoma/Documents/GitHub/ztests")

# 2. Read in the data -----------------------------------------------------

df.linux.mrgsite25 <- times2df("results_linux_BIOTI25site.yaml")
df.win.mrgsite25 <- times2df("results_windows_LH2-BIOTI25.yaml")
df.win.mrgtesla <- times2df("results_windows_MRGTESLA.yaml")

# Fix the machine names for Linux
df.linux.mrgsite25$machine <- "LH2-BIOTI25 (Linux)"

# Merge all data
df.dat <- rbind(df.linux.mrgsite25, df.win.mrgsite25, df.win.mrgtesla)
# Set upt the run info as factors
df.dat$run <- factor(rep(15:20, 3))

# 3. Stats ----------------------------------------------------------------

mean((df.win.mrgtesla$elapsed / df.linux.mrgsite25$elapsed))
(mean(df.win.mrgsite25$elapsed / df.win.mrgtesla$elapsed))
(mean(df.win.mrgsite25$elapsed / df.linux.mrgsite25$elapsed))
(sd(df.linux.mrgsite25$elapsed / df.win.mrgsite25$elapsed))

# 4. Plotting -------------------------------------------------------------

# 4.1 Total elapsed time --------------------------------------------------

p <- ggplot(df.dat, aes(elapsed, x=run, fill=machine, group=machine)) + 
     geom_bar(stat="identity", position="dodge")
p + theme(axis.text.x = element_text(size=18)) + ylab("Seconds") + xlab("Run") +
  scale_x_discrete(labels=c(15:20)) + ggtitle("Total elapsed time")

# 4.2 Init -----------------------------------------------------------

p <- ggplot(df.dat, aes(y=init, x=run, fill=machine)) + 
  geom_bar(position="dodge", stat="identity")
p + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + ylab("Seconds") +
  ggtitle("Initiation stage")


# 5. Result comparison ----------------------------------------------------

diffs <- yaml.load_file("raster_differences.yaml")
diffs <- do.call("rbind", lapply(diffs, differences2df))
df.diffs <- data.frame(diffs)
df.diffs <- df.diffs[with(df.diffs, order(file1)), ]