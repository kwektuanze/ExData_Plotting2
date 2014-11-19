# Load data (can take a while to load)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland motor vehicle sources
Maryland_motor <- subset(NEI, fips == '24510' & type == 'ON-ROAD')

# Aggregate to get motor vehicle sources emissions
Maryland_motor_emissions <- aggregate(Maryland_motor[, 'Emissions'], by = list(Maryland_motor$year), sum)

# Plot of total emissions of motor vehicle sources in Baltimore City
png(filename = 'plot5.png')
plot(Maryland_motor_emissions, type = "l", xlab = "Year", ylab = expression('Total PM'[2.5]*" Emission"),
     main = "Total Emissions of Motor Vehicle Sources in Baltimore City")
dev.off()