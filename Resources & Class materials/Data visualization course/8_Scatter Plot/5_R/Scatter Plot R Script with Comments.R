library("ggplot2") # visualization library
library("wesanderson") # color palettes inspired by wes anderson films

# load real estate data set for scatter plot
df_real_estate <- read.csv("../scatter_data.csv", 
                           header = TRUE, 
                           sep = ",")
scatter <- ggplot(df_real_estate,
                  aes(x = Area..ft..,
                      y = Price)) +
                  geom_point(aes(color = factor(Building.Type), #choosing the factor to paint the dots
                                 size = 2), #size of the points on the scatter
                              alpha = 0.4) + #transparency level for the points
                  guides(size = FALSE) + #remove the guides legend
                  labs(color = "Building Type") +
          scale_color_manual(values = wes_palette(name = "Darjeeling1", 
                                                  n = 5)) +
        #add and format non data elements:legend, title and axis labels
         theme_classic() +
         theme(legend.justification = c(0.01, 1), 
               legend.position = c(0.01,1)) +
         ggtitle("Relationship between Area and Price of California Real Estate") +
         ylab("Price (000's of $)") +
         xlab("Area (sq. ft.)")
         
scatter
names(wes_palettes)


