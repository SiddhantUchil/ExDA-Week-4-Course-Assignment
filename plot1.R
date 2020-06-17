library(ggplot2)
library(dplyr)
library(tidyr)
##called these libraries in advance in case I need them

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "data.zip")
##downloaded the required zip file

##extracted the zip file and renamed "Source_Classification_Code.rds" as "code.rds" and "summarySCC_PM25.rds" as "data.rds"

a = readRDS("code.rds")
b = readRDS("data.rds")


Total.Pollution <- with(b, tapply(b$Emissions, b$year, sum, na.rm = TRUE))
##used tapply to find the total emissions per year, this is an array


Total.Pollution <- data.frame( year = names(Total.Pollution), quantity = Total.Pollution)
##transformed the array to a dataframe to ease my plotting

png( filename = "plot1.png", width = 480, height = 480)
##created a png file in advance so that there is no issue in fitting the entire plot


plot(Total.Pollution$year, Total.Pollution$quantity, type = "l", xlab = "Year", ylab = "emissions in tonnes", main = "total emissions across the years")
##line graph is used because I believe it is the most effective way to show a change in data over time 

dev.off()
##closes the png engine