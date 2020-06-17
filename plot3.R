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


f = tapply(d$Emissions, list(d$year, d$type), sum)
##this gives a matrix and I would have to use par(mfrow) to plot 4 different line graphs 
##this piece is not used in the final code

with(f, plot(f[ , 1], d$year), pch = 9)
##not used, just plots 1 line graph

g = data.frame(year = names(f), total = f)
##I am not able to convert it into a dataframe

h = aggregate(Emissions ~ year + type, data = d, FUN = sum)
##is much easier than using tapply

png( filename = "plot3.png", width = 480, height = 480)
##created a png file in advance so that there is no issue in fitting the entire plot

i = ggplot(data = h, mapping = aes(year, Emissions, color = type))
##initial mapping using ggpplot2
##had some issue when I used aes(factor(year))

i = ggplot(data = h, mapping = aes(factor(year), Emissions))
##when you use factor(year), it shows the range of the total emissions in that year

i + geom_line() + ggtitle(("Changes in emissions from 4 sources in Baltimore"))
##added line graphs to show the change in data over time

dev.off()
##closes the png engine