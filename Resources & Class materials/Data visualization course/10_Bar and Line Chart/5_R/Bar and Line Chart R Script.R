library(ggplot2)

df_kdnuggets <- read.csv("bar_line_chart_data.csv", 
                         header = TRUE)
combo <- ggplot(df_kdnuggets, 
                aes(x = Year, 
                    y = Participants, Python.Users)) +
         geom_bar(aes(y = df_kdnuggets$Participants), 
                  stat = "identity",
                  fill = "black") +
         geom_line(aes(y = df_kdnuggets$Python.Users*max(df_kdnuggets$Participants)),
                   stat = "identity", 
                   color = "red", 
                   size = 2) +
        scale_y_continuous(sec.axis = sec_axis(~./max(df_kdnuggets$Participants)*100, 
                                               name = "Python Users in %")) +
        ggtitle("KD Nuggets Survey Python Users (2012 - 2019)")        


combo
