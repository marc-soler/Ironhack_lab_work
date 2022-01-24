library("ggplot2")
#make sure to write path using /, otherwise R will not read it.
car_sales <- read.csv(file="C:/Users/nikol/Documents/ElitsaK/Data Visualization/3. Bar chart/bar_chart_data.csv",
                      header=TRUE,
                      sep=",")

bar <- ggplot(car_sales, aes(x = Brand, y = Cars.Listings)) +
  geom_bar(stat = "identity", width = 0.8, color = "navy", fill = "navy")  + 
  ggtitle('Car Listings by Brand') + 
  theme_classic() + 
  labs (x = NULL, y = 'Number of Listings') +
  geom_text(aes(label = Cars.Listings), hjust = -0.2) +
  coord_flip() #with this command, we're able to switch the places between the x and y-axis on the chart.
bar
