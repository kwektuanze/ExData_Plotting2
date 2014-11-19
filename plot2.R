# Load data (can take a while to load)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore City, Maryland emissions
Maryland <- subset(NEI, fips == '24510')

# Aggregate emissions of Maryland by year
Emissions <- aggregate(Maryland$Emissions, list(Maryland$year), FUN = "sum")

# Plot of total PM2.5 emission in Baltimore City, Maryland from 1999 to 2008
png(filename = 'plot2.png')
plot(Emissions, type = "l", xlab = "Year", 
     ylab = expression('Total PM'[2.5]*" Emission"),
     main = "Total Emissions in Baltimore City from 1999 to 2008")
dev.off()