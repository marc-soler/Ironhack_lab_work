library(ggplot2)

df_ad_expenditure <- read.csv("scatter_plot_ii.csv", 
                              header = TRUE, 
                              sep = ",")

regression_scatter <- ggplot(df_ad_expenditure,
                             aes(x = Budget, 
                                 y = Sales)) +
                      geom_point(size = 3, 
                                 color = 'grey12') +
                      geom_smooth(method = lm, 
                                  color = "red", 
                                  fill = "red") +
                                  #,se = FALSE) 
                      theme_classic() +
                      xlab("Ad Expenditure in (000's $)") +
                      ylab("Sales in (000's Units)") +
                      ggtitle("Effect of Ad Expenditure on Sales")
regression_scatter
