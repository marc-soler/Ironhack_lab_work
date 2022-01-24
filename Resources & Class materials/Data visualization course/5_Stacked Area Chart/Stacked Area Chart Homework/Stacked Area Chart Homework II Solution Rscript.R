library("ggplot2")
library("dplyr")
library("reshape2")

df_revenue_2020 <- read.csv("area_chart_homework_data.csv",
                            header = TRUE,
                            sep = ",")
# We need to transform the Date column into the specific date format. 
# Otherwise we'd have trouble processing the data
# We select the format month/day/year to reflect our original data feature(which has the same format)
df_revenue_2020$Date <- as.Date(df_revenue_2020$Date,
                       format = "%m/%d/%y")

#reorder columns in data frame, so the categories are from smallest to largest 
temp <- df_revenue_2020[, c(1, 3, 4, 2)]

new_revenue <- melt(temp, id.vars = "Date")

#This Stacked Area Chart displays the company's monthly revenue for the year 2020.
#For this chart it's important to order the categories from largest to smallest for better readability 
#A bright color (such as yellow) would make the smallest category stand out more, however, 
#for this chart, you're welcome to explore your own color palettes.

area_chart <- ggplot (new_revenue,
                      aes(x = Date,
                          y = value,
                          fill = variable)) +
                      geom_area() +
             scale_fill_manual(values = c("#ffc000",
                                          "#31859C",
                                          "#215968")) +
              theme_classic() +

              labs(fill = "Revenue Sources") +
              ylab("Revenue in $") +
              ggtitle("Revenue Report 2020") +
              theme(axis.text.x = element_text(angle = 45,
                                               vjust = 0.5)) +
              scale_x_date(breaks = new_revenue$Date) # adding breaks for column in date format
area_chart 

