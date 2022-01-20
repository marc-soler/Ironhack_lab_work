library(ggplot2)

df_auto_insurance <- read.csv("regression_auto_insurance_sweden.csv", 
                              header = TRUE, 
                              sep = ",")

regression_scatter <- ggplot(df_auto_insurance,
                             aes(x = Claims, 
                                 y = Payment)) +
                      geom_point(size = 3, 
                                 color = 'grey12') +
                      geom_smooth(method = lm, 
                                  color = "red", 
                                  fill = "red") +
                                  #,se = FALSE) 
                      theme_classic() +
                      xlab("Claims") +
                      ylab("Payment") +
                      ggtitle("Car Insurance Claims and Payment in Sweden")
regression_scatter
