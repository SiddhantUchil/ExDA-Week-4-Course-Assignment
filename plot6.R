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

i = c[grepl('vehicle',c$EI.Sector,ignore.case=TRUE), ]
##this included all the vehicles

j = subset(i, i$fips == "24510" | i$fips == "06037" )
j = select(j, Emissions, EI.Sector, year, fips)
k = aggregate(Emissions ~ ., data = j, FUN = sum)
## summed up emissions as per all the remaining variables
##as a result using select() in the previous step is really helpful
##I think this is similar to using melt()

str(k)
k = droplevels(k)
library(varhandle)
k$EI.Sector = unfactor(k$EI.Sector)


png( filename = "plot6.png", width = 960, height = 960)
##created a png file in advance so that there is no issue in fitting the entire plot

g = ggplot(data = k, aes(year, Emissions, color = fips, label = round(Emissions, 0)))
g + geom_line() + geom_point() + facet_wrap(. ~ EI.Sector) + geom_text() + ggtitle("comparing baltimore and los angeles") + scale_color_hue(labels = c("los angeles", "baltimore"))
## I believe that line graphs are the best method to show changes over time

dev.off()
##closed the png engine