# Last Action
# backlog
library('tidyr')
library('dplyr')

code_violations <- tbl_df(read.csv("mappedcedcases3years_datasd.csv", stringsAsFactors = FALSE))


code_violations.time = 
  code_violations %>% 
  mutate(
    MONTH_OPEN=format(as.POSIXlt(open_date,"America/Los_Angeles"),"%m"),
    YEAR_OPEN=format(as.POSIXlt(open_date,"America/Los_Angeles"),"%Y"),
    WEEK_OPEN=format(as.POSIXlt(open_date,"America/Los_Angeles"),"%U"),
    CLOSE_DATE0=ifelse(nchar(as.character(close_date))>0,close_date,NA),
    MONTH_CLOSED= format(as.POSIXlt(CLOSE_DATE0,"America/Los_Angeles"),"%m"),
    YEAR_CLOSED= format(as.POSIXlt(CLOSE_DATE0,"America/Los_Angeles"),"%Y")
  )

code_violations.lastaction = code_violations.time %>% group_by(last_action) %>% summarize(count=n())

code_violations.lastaction.open = code_violations.time %>% filter(close_date == "") %>% group_by(last_action) %>% summarize(count=n())

write.csv(code_violations.lastaction, "code_violations_last_action.csv")
write.csv(code_violations.lastaction.open, "code_violations_open_last_action.csv")
