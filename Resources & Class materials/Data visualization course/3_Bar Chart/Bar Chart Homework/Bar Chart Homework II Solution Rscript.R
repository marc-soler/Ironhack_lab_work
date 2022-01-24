library("ggplot2")

df_ice_cream_sales <- read.csv(file="bar_chart_homework_data.csv",
                      header=TRUE,
                      sep=",")

#create a bar chart based on the ice cream sales data
bar <- ggplot(df_ice_cream_sales, 
                         aes(x = Cities, y = Frequency)) +
  geom_bar(stat = "identity", width = 0.8, color = "navy", fill = "navy")  + 
  ggtitle('Sales') + 
  theme_classic() + 
  labs (x = NULL, y = 'Frequency') +
  geom_text(aes(label = Frequency), hjust = 0.5, vjust = -0.5) 
bar

#This is a horizontal bar chart displaying the same data. The y and x-axis are reversed using coord_flip()
horizontal_bar <- ggplot(df_ice_cream_sales, 
              aes(x = Cities, y = Frequency)) +
  geom_bar(stat = "identity", width = 0.8, color = "navy", fill = "navy")  + 
  ggtitle('Sales') + 
  theme_classic() + 
  labs (x = NULL, y = 'Frequency') +
  geom_text(aes(label = Frequency), hjust = -0.2) +
  coord_flip() #with this command, we're able to switch the places between the x and y-axis on the chart.
horizontal_bar
