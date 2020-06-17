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


h = c[c$type == "ON-ROAD", ]
##I did not use this since it did not include 3 vehicles of type "point"

i = c[grepl('vehicle',c$EI.Sector,ignore.case=TRUE), ]
##this included all the vehicles


j = setdiff(i, h)
View(j)
##I used this to check which were missing in h


k = subset(i, i$fips == "24510")
##extracted only the Baltimore data
##I put 24510 in quotes because the class of "fips" is character and not numeric 
class(i$fips)

names(k)
unique(k$EI.Sector)
k = droplevels(k)
##when you see the unique values of EI.Sector there are a lot of unwanted factor levels
##Hence use droplevels() to remove them

View(k)
l = aggregate(Emissions ~ EI.Sector + year, data = k, FUN = sum)
str(l)
library(varhandle)
l$EI.Sector = unfactor(l$EI.Sector)

png( filename = "plot5.png", width = 960, height = 960)
##created a png file in advance so that there is no issue in fitting the entire plot

g = ggplot(data = l, mapping = aes(year, Emissions, label = round(Emissions, 0)))
g + geom_line() + geom_point() + facet_wrap(.~EI.Sector) + geom_text() + ggtitle("motor vehicle emissions changes in Baltimore")
##the slope of the line graphs makes it easy to understand which type of coal combustion emissions changed the most
##across the years

dev.off()
##closed the png engine