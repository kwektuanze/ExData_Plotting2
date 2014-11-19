# Load ggplot2 package
library(ggplot2)

# Load data (can take a while to load)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get coal combustion-related Source Classification Code (SCC)
SCC_coal = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

# Merge to get coal combustion-related sources emissions
merge <- merge(x = NEI, y = SCC_coal, by = 'SCC')

# Aggregate emissions by year
Emissions <- aggregate(merge[, 'Emissions'], by = list(merge$year), sum)
colnames(Emissions) <- c('Year', 'Emissions')

# ggplot2 plot of coal combustion-related sources emissions (in Kilotons) from 1999–2008 across the United States
ggplot(data = Emissions, aes(x = Year, y = Emissions / 1000)) + geom_line(aes(group = 1, col = Emissions)) + geom_point(aes(col = Emissions)) + ggtitle(expression('Total Emissions of PM'[2.5])) + ylab(expression(paste('PM', ''[2.5], ' in Kilotons')))
ggsave('plot4.png')
dev.off()