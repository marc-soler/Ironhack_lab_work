library("ggplot2")

df_survey <- read.csv("histogram_survey_data.csv",
                           header = TRUE,
                           sep = ",")

#to create bins for the x-axis we'll first transform the age variable by dividing it into intervals of length 5
df_survey$interval <- cut(df_survey$Age, seq (0, 80, by = 5))

hist <- ggplot(df_survey ,
               aes(x = interval)) +
        geom_histogram(stat = "count",
               bins = 8,
               fill = "palegreen3",
               color = "white") +
        theme_classic() +
        ggtitle("Distribution of Real Estate Prices") +
        theme(plot.title = element_text(size = 16, 
                                        face = "bold")) +
        xlab("Price in (000' $)") +
        ylab("Number of Properties") 

hist

