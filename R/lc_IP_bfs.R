rm(list=ls())
library(tidyverse)

# Source functions
source("./R/utils/f.getIP.R")

#Download IP (monthly) data
f.getIP()

# Rename the file accordingly
details <- file.info(list.files(recursive = T, pattern = ".xlsx"))
details <- details[with(details, order(as.POSIXct(mtime), decreasing = T))[1],] # only keep most recent
file.rename(rownames(details),"data/IP_monthly.xlsx")

# Make it tidy
IP_data <- readxl::read_excel('data/IP_monthly.xlsx', skip =2)
colnames(IP_data)[1:8] <- c("adjustments", "adjustments_lab", "indORchange", "indORchange_lab", "nomORreal", "nomORreal_lab", "var", "var_lab")

IP_data <- IP_data %>%
  tidyr::fill(names(IP_data), .direction = "down")

save(IP_data, file = "R/lc_IP_bfs.RData")



