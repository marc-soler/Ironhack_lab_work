#required libraries for the stacked area chart
library("ggplot2") # visualization
library("dplyr") # data manipulation 
library("reshape2") # data transformation. For instance from wide to long format

# Load data. Engine Fuel Types for used cars. Data is collected from 1982 until 2016 and has four categories: Gas, Petrol, Diesel, Other
df_engine_types <- read.csv("../stacked_area_chart_data.csv",
                            header = TRUE,
                            sep = ",")
# Remove 'other' category. We have no prior information on this category,
# so we omit it for better chart readability. This step is necessary,
# as we're later melting the remaining categories into one.
temp <- select(df_engine_types, -matches("Other"))
# Combine diesel, petrol and gas categories into one column, to create the stacked area chart. 
# The new data has 3 columns - Year, Variable and Value. Variable shows the engine fuel category.
# Value displayes the number of cars sold for the respective year and from that category.
new_engine_types <- melt(temp, id.vars = "Year")
# Create a stacked area chart with ggplot2. For an area chart, the required geometry is 'geom_area'
area_chart <- ggplot (new_engine_types, # data layer
                      aes(x = Year, # aesthetics
                          y = value,
                          fill = variable)) +
  geom_area() +
  scale_fill_manual(values = c("#ef2026", #custom colors for each of the three categories
                               "#7e2987",
                               "#011638")) +
  theme_classic() + #legend
  theme(legend.justification = c(0.01, 1), #specify a legend position
        legend.position = c(0.01, 1)) +
  labs(fill = "Engine Type") + #title name
  ylab("Number of Cars") + #y-axis name
  ggtitle("Popularity of Engine Fuel Types (1982 - 2016)") + #charts title
  theme(axis.text.x = element_text(angle = 90, #adding x-axis labels for each years and rotating them for better readability 
                                   vjust = 0.5)) +
  scale_x_continuous(breaks = new_engine_types$Year)

area_chart  
