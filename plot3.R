# Load ggplot2 package
library(ggplot2)

# Load data (can take a while to load)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore City, Maryland emissions
Maryland <- subset(NEI, fips == '24510')

# ggplot2 plot of emission sources ((point, nonpoint, onroad, nonroad) from 1999–2008 for Baltimore City
ggplot(Maryland, aes(year, Emissions, color = type)) + geom_line(stat = "summary", fun.y = "sum") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle("Total Emissions in Baltimore City from 1999 to 2008")
ggsave('plot3.png')
dev.off()