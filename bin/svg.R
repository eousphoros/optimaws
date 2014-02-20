library(RSvgDevice)
args <- commandArgs(trailingOnly = TRUE)
region = args[1]
term = args[2]
restype = args[3]
instance_type = parse(text=args[4])
on_demand_hourly = eval(parse(text=args[5]))
reserve_hourly = eval(parse(text=args[6]))
reserve_year = eval(parse(text=args[7]))
file <- paste(region,term,restype,instance_type,"svg", sep=".")
print(file)

on_demand_daily = on_demand_hourly * 24
reserve_daily_year = reserve_hourly * 24

if(term == 'year3') x <- c(0, 1095) else x <- c(0, 365)

y <- on_demand_daily * x

break_year_x = reserve_year / (on_demand_daily - reserve_daily_year)

devSVG(file, width = 8, height=5)
plot(x,y, type="l", col='red', xlab="Time", ylab="cost ($USD)")
title(sprintf("Utilization: %s Region: %s Instance: %s\n%s term is cheaper than on-demand after %.0f days of usage", restype, region, instance_type, term, break_year_x))
text(60, 0, sprintf("on-demand=$%.2f/hour", on_demand_hourly), pos=3)

abline(reserve_year, reserve_daily_year, col='green')
text(60, reserve_year, sprintf("Reserved=$%.0f+$%.2f/hour", reserve_year, reserve_hourly), pos=3)

point_y = reserve_year + reserve_daily_year * break_year_x
points(break_year_x, point_y)
text(break_year_x, point_y, labels = sprintf("%.0f days", break_year_x), pos=1)

dev.off()
quit()
