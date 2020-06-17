library(ggplot2)
library(dplyr)
library(tidyr)
##called these libraries in advance in case I need them

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "data.zip")
##downloaded the required zip file

##extracted the zip file and renamed "Source_Classification_Code.rds" as "code.rds" and "summarySCC_PM25.rds" as "data.rds"

a = readRDS("code.rds")
b = readRDS("data.rds")

c = merge(a, b, by = "SCC")
##merge is used to assimilate all data in both the dataframes and "SSC" is a common field

d = subset(c, c$fips == 24510)
##extracts only the Baltimore data

d$year = as.Date(as.character(d$year), "%Y") ##this seems to cause problems
class(d$year)
##there is no need to do this as the year column only consists of the years
##my final code does not contain this piece

e = with(d, tapply(d$Emissions, d$year, sum, na.rm = TRUE))
##used tapply to find the total emissions per year, this is an array
##instead of tapply we can use the aggregate function as well

e = data.frame( year = names(e), total = e)
##transformed the array to a dataframe to ease my plotting

png( filename = "plot2.png", width = 480, height = 480)
##created a png file in advance so that there is no issue in fitting the entire plot

plot(e$year, e$total, type = "l", xlab = "year", ylab = "total emissions", main = "emissions in Baltimore")
##line graph is used because I believe it is the most effective way to show a change in data over time

dev.off()
##closes the png engine