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

##unwanted code starts
y = c[grepl("^Fuel Comb", c$EI.Sector, ignore.case = TRUE), ]
##emissions from coal are a result of fuel combustion, so I first grepped for Fuel Comb

z = y[grepl("coal", y$EI.Sector, ignore.case = TRUE),  ]
##I then refined it further by searching specifically for coal


View(z)
View(unique(z$EI.Sector))

tapply(z$Emissions,  z$year, sum, na.rm = TRUE)

str(z)
sum(!is.na(z$EI.Sector))

o = tapply(n$Emissions, list(n$EI.Sector, n$year), sum, na.rm = TRUE)
o = t(o)
n = droplevels(z)

o = data.frame(o)
row.names(o) = e$year
attr(o, "row.names")
with(o, plot(attr(o, "row.names"), o$Fuel.Comb...Comm.Institutional...Coal, type = "l"))

length(row.names(o))
length(o[,1])
plot(row.names(o), o[,1])
##unwanted code ends

p = c[grepl("Fuel Comb.*Coal", c$EI.Sector, ignore.case = TRUE),   ]
##I combined the above 2 grep into a single grep
##any of the two methods can be used, the results were the same

p = droplevels(p)
##P initially contained a lot of other factor levels having NA values because of the subsetting
##droplevels() removes those factors

str(p)
##the change in the structure before and after using droplevels() can be checked

q = select(p, year, Emissions, EI.Sector )
##extracted only the needed data

q = aggregate(Emissions ~ year + EI.Sector, data = q, FUN = sum )
##divided emissions according to the year and type of coal combustion

str(q)
##you can see that EI.Sector is a factor. This causes issues while plotting as it restricts data being spread in a 
##continuous manner

install.packages("varhandle")
library(varhandle)
q$EI.Sector = unfactor(q$EI.Sector)
##I used this to change EI.Sector from a factor back to a normal character

png( filename = "plot4.png", width = 960, height = 960)
##created a png file in advance so that there is no issue in fitting the entire plot
 
g = ggplot(data = q, mapping = aes(year, Emissions, label = round(Emissions, 0)))
 g + geom_line() + geom_point() + facet_wrap(.~EI.Sector) + geom_text() + ggtitle("changes in coal combustion emissions")
 ##the slope of the line graphs makes it easy to understand which type of coal combustion emissions changed the most
 ##across the years
 
 dev.off()
 ##closed the png engine