# Load ggplot2 package
library(ggplot2)

# Load data (can take a while to load)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Motor vehicle sources (Baltimore City, Maryland)
Maryland_motor <- subset(NEI, fips == '24510' & type == 'ON-ROAD')

# Motor vehicle sources (Los Angeles County, California)
California_motor <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate to get motor vehicle sources emissions (Baltimore City, Maryland)
Maryland_motor_emissions <- aggregate(Maryland_motor[, 'Emissions'], by = list(Maryland_motor$year), sum)
colnames(Maryland_motor_emissions) <- c('year', 'Emissions')
Maryland_motor_emissions$City <- paste(rep('Baltimore City', 4))

# Aggregate to get motor vehicle sources emissions (Los Angeles County, California)
California_motor_emissions <- aggregate(California_motor[, 'Emissions'], by = list(California_motor$year), sum)
colnames(California_motor_emissions) <- c('year', 'Emissions')
California_motor_emissions$City <- paste(rep('Los Angeles County', 4))

# Combined motor vehicle sources emissions
Combined_motor_emissions <- rbind(Maryland_motor_emissions, California_motor_emissions)

# Plot of comparison of total emissions from motor vehicle sources in Baltimore City and Los Angeles County
ggplot(Combined_motor_emissions, aes(year, Emissions, color = City)) + 
  geom_line(stat = "summary", fun.y = "sum") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Comparison of Total Emissions From Motor Vehicle\n Sources in Baltimore City and Los Angeles County") +
  scale_colour_discrete(name = "City", label = c("Los Angeles County","Baltimore City"))
ggsave('plot6.png')
dev.off()