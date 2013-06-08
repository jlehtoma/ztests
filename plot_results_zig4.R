library(ggplot2)
library(reshape2)
library(yaml)

source("utilities.R")

# 1. Setup ----------------------------------------------------------------

setwd("/home/jlehtoma/opt/zonation-3.1.9-GNU-Linux/ztests/")

# 2. Read in the data -----------------------------------------------------

df.linux.zig3 <- times2df("results_linux_BIOTI25site.yaml")
df.linux.zig4 <- times2df("results_linux_BIOTI25site_zig4.yaml")

# Fix the machine names for Linux
df.linux.zig3$machine <- "LH2-BIOTI25 (zig3)"
df.linux.zig4$machine <- "LH2-BIOTI25 (zig4)"

# Merge all data
df.dat <- rbind(df.linux.zig3, df.linux.zig4)
# Set upt the run info as factors
df.dat$run <- factor(rep(15:20, 2))

# 3. Stats ----------------------------------------------------------------

mean((df.linux.zig4$elapsed / df.linux.zig3$elapsed))

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