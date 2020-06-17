a = readRDS("code.rds")
head(a)
names(a)
View(head(a))

b = readRDS("data.rds")
names(b)
table(b$Emissions)

Total.Pollution <- with(b, tapply(b$Emissions, b$year, sum, na.rm = TRUE))
Total.Pollution
Total.Pollution <- data.frame( year = names(Total.Pollution), quantity = Total.Pollution)
plot(Total.Pollution$year, Total.Pollution$quantity, pch = 9)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "data.zip")

match(24510, b$fips)
str(b$fips)
View(head(a, 300))

c = merge(a, b, by = "SCC")
View(head(c, 300))

d = subset(c, c$fips == 24510)
d$year = as.Date(as.character(d$year), "%Y") ##this seems to cause problems
class(d$year)
e = with(d, tapply(d$Emissions, d$year, sum, na.rm = TRUE))
names(e)
e = data.frame( year = names(e), total = e)
plot(e$year, e$total, pch = 19, type = "l")

f = tapply(d$Emissions, list(d$year, d$type), sum)
f = data.frame(year = names(f), total = f)
tapply(f$total, d$type, mean )
with(f, plot(f[ , 1], e$year), pch = 9)
f[ , 1]

g = data.frame(f)
row.names(g) = e$year
g

attr(g, "row.names")
?row.names

with(g, plot(attr(g, "row.names"), g$NON.ROAD), type = "l")

?grep

library(dplyr)
library(tidyr)
subset(g, grep("^15",g$NONPOINT, value = TRUE))

g[grepl("15",g$NONPOINT), ]

x = c[grepl("Coal", c$SCC.Level.Four, ignore.case = TRUE), ]

unique(x$type)
View(unique(x$SCC.Level.One))
View(unique(c$SCC.Level.Four))
names(c)
View(unique(c$EI.Sector))


y = c[grepl("^Fuel Comb", c$EI.Sector, ignore.case = TRUE), ]
View(y)

z = y[grepl("coal", y$EI.Sector, ignore.case = TRUE),  ]

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

p = c[grepl("Fuel Comb.*Coal", c$EI.Sector, ignore.case = TRUE),   ]
p = droplevels(p)
str(p)

View(unique(c$type))


install.packages("xlsx")
library(xlsx)

h = c[c$type == "ON-ROAD", ]
View(unique(h$SCC.Level.Four))

i = c[grepl('vehicle',c$EI.Sector,ignore.case=TRUE), ]

j = anti_join(h, i, by = )

j = setdiff(i, h)
View(j)



k = subset(i, i$fips == "24510")
View(k)

l = subset(i, i$fips == "06037")
View(l)

class(i$fips)

k1 = tapply(k$Emissions, k$year, sum, na.rm = TRUE )
k1
plot(k1, type = "l")
geom.lines(k2, col = "red")
k2 = tapply(l$Emissions, l$year, sum, na.rm = TRUE)



a1 = k[ , c(k$Emissions, k$year, k$fips)]

a1 = select(k, Emissions, year, fips)
View(a1)
a2 = tapply(a1$Emissions, a1$year, sum, na.rm = TRUE)
a2 = data.frame(a2)
names(a2)

b1 = select(l, Emissions, year, fips)
b2 = tapply(b1$Emissions, b1$year, sum, na.rm = TRUE)

b2 = data.frame(b2)
b2
attr

ab = merge(a2,b2)
ab

ab1 = cbind(a2, b2)
ab1

ab1$year = attr(ab1, "row.names")
plot(ab1$year, ab1$a)
abline(lm(ab1$year ~ ab1$a2))

abline(lm(a2 ~ year))
lines(ab1$year, ab1$b2, col = "red")

?abline
??method

