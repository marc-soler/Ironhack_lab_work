library(ggplot2) #visualization library

df_kdnuggets <- read.csv("../bar_line_chart_data.csv", #read in the KDnuggets survey data file
                         header = TRUE) #include column names in the data frame
#creating the ggplot2 combination chart
combo <- ggplot(df_kdnuggets, 
                aes(x = Year, 
                    y = Participants, Python.Users)) + #include both primary and secondary y-axis columns
#creating the bar chart
    geom_bar(aes(y = df_kdnuggets$Participants), 
           stat = "identity", #plot the num of participants for each year.
           fill = "black") +
#creating the line chart  
  geom_line(aes(y = df_kdnuggets$Python.Users*max(df_kdnuggets$Participants)), #scale the y axis of the line chart, so it has the same order of magnitude as bar chart
            stat = "identity", 
            color = "red", 
            size = 2) +
  scale_y_continuous(sec.axis = sec_axis(~./max(df_kdnuggets$Participants)*100, #rescale line chart y-axis and convert to percentage scale 
                                         name = "Python Users in %")) +
  ggtitle("KD Nuggets Survey Python Users (2012 - 2019)")        


combo
