library("ggplot2")

df_student_scores <- read.csv("student_scores_data.csv", 
                           header = TRUE, 
                           sep = ",")
scatter <- ggplot(df_student_scores,
                  aes(x = SAT,
                      y = GPA)) +
                  geom_point(color = "midnightblue", size = 4) +
         theme_classic() +
         ggtitle("GPA and SAT Student Scores") +
         ylab("GPA") +
         xlab("SAT")
         
scatter

