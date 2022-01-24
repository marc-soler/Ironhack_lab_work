library(ggplot2)

df_movie_complaints <- read.csv("bar_line_chart_homework.csv", 
                         header = TRUE)

# Creating the Pareto chart based on the movie goers complaints data.
# What we observe is that there seems to be a linear relationship between the two variables. 
# The higher the insurance claim, the higher the payment it has received.
combo <- ggplot(df_movie_complaints, 
                aes(x = reorder(Movie.Theater.Goers.Complaints, -Number.of.complaints), #reorder bars by number of complaints, instead of type of complaint
                    y = Number.of.complaints, frequency)) +
         geom_bar(aes(y = df_movie_complaints$Number.of.complaints), 
                  stat = "identity",
                  fill = "black") +
         geom_line(aes(y = df_movie_complaints$frequency*max(df_movie_complaints$Number.of.complaints),
                       group = 1),
                   stat = "identity", 
                   color = "red", 
                   size = 2) +
        scale_y_continuous(sec.axis = sec_axis(~./max(df_movie_complaints$Number.of.complaints)*100, 
                                               name = "frequency in %")) +
        theme(axis.title.x=element_blank()) +
        ggtitle("Top 5 Movie Goers Complains Frequency Distribution")        


combo
