library("ggplot2") #visualization library
#load the real estate data set for the histogram
df_real_estate <- read.csv("../histogram_data.csv",
                           header = TRUE,
                           sep = ",")
#for a ggplot histogram the geometry is geom_histogram
hist <- ggplot(df_real_estate,
               aes(x = Price)) +
        geom_histogram(bins = 8, #determine the number of bins
                       fill = "#108A99",
                       color = "white") +
        theme_classic() +
        ggtitle("Distribution of Real Estate Prices") +
        xlab("Price in (000' $)") +
        ylab("Number of Properties") +
        theme(plot.title = element_text(size = 16, #title formatting
                                        face = "bold"))
hist
