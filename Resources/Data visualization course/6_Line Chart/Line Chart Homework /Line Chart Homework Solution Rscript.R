library(ggplot2)
library(reshape2)
library(plyr)

spx_ftse_10_20 <- read.csv("returns1020.csv",
                           header = TRUE,
                           sep = ",")
spx_ftse_10_20$Date <- as.Date(spx_ftse_10_20$Date,
                               format = "%m/%d/%Y")
spx_ftse_10_20_melt <- melt(spx_ftse_10_20,
                            id = "Date")
spx_ftse_10_20_melt <- rename(spx_ftse_10_20_melt,
                              c("value" = "Returns",
                                "variable" = "Index"))
line_chart <- ggplot(spx_ftse_10_20_melt,
                     aes(x = Date,
                         y = Returns,
                         colour = Index,
                         group = Index)) +
              geom_line(aes(color = Index),
                        size = 1) +
              scale_color_manual(values = c("navyblue", "red4")) +
              theme_minimal() +
              ggtitle("S&P vs FTSE Returns (2000 - 2010)")
line_chart

min <- as.Date("2015-7-1")
max <- as.Date("2015-12-31")

line_chart_H2_15 <- ggplot(spx_ftse_10_20_melt,
                     aes(x = Date,
                         y = Returns,
                         colour = Index,
                         group = Index)) +
  geom_line(aes(color = Index),
            size = 1) +
  scale_color_manual(values = c("navyblue", "red4")) +
  theme_minimal() +
  ggtitle("S&P vs FTSE Returns (H2 2015)") +
  scale_x_date(limits = c(min, max)) + 
  theme(legend.justification = c(0.01, 1),
        legend.position = c(0.01, 1))
line_chart_H2_15

