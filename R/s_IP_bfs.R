# Select data bfs
rm(list=ls())
load("R/lc_IP_bfs.RData")
# Get some info on the structure
# Open file "data/IP_monthly.px"

# Define what you want
adj <- c("brut", "sa") # unique(IP_data$adjustments)[1:4] with labels unique(IP_data$adjustments_lab)[1:4]
iOc <- "ind"
nOr <- c("n")
v_lab  <-  c("47: Total retail sector") # unique(IP_data$var_lab)

IP_data_sel <- IP_data  %>%
  filter(adjustments %in% adj & indORchange == iOc & nomORreal %in% nOr & var_lab %in% v_lab) %>%
  tidyr::gather(key=date,value=value,-c(1:8)) %>%
  select(date, everything()) %>%
  mutate(date = as.Date(paste0(date,"-15"), format = "%YM%m-%d"))

write.csv(IP_data_sel, file = "data/sel_IP_monthly.csv", row.names = FALSE)
