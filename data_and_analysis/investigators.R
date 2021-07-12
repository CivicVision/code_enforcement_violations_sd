# Investigators
library('tidyr')
library('dplyr')

investigators = tbl_df(read.csv("ceddirectname.csv", stringsAsFactors = FALSE))

investigators.full_name = investigators %>% mutate(full_name=paste(Last,First,sep=", "),alternate_full_name=paste(Last,Name,sep=", "))

code_violations.closing_rate.investigator.active = code_violations.closing_rate.investigator %>% mutate(active=(investigator_name %in% investigators.full_name$full_name || investigator_name %in% investigators.full_name$alternate_full_name))
