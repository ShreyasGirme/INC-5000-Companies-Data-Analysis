library(tidyverse)
#check the 
str(df)

#to check how many rows and columns are in a data set
dim(df)

#to check the missing values 
colSums(is.na(df))


drops <- c('_input')
drops
df <- df[ ,!(names(df) %in% drops)]
view(df)

#to remove rows with missing values

df <- df[ ,!(names(df) %in% drops)]

dim(df)

#to remove duplicates 
df <-df %>% distinct(id, .keep_all = TRUE)

#if you want to round off any column. In this case we will tound off growth column

df$growth <- round(df$growth ,digit=2)

#new library
library(ggplot2)

#to remove outlier

ggplot(df, aes(x=revenue, y=growth)) + geom_boxplot(outlier.colour = "red", outlier.shape = 1)+ scale_x_continuous(labels = scales::comma)+coord_cartesian(ylim = c(0, 1000))



Q1 <- quantile(df$growth, .25)
Q3 <- quantile(df$growth, .75)
IQR <- IQR(df$growth)
no_outliers <- subset(df, df$growth> (Q1 - 1.5*IQR) & df$growth< (Q3 + 1.5*IQR))

Q1 <- quantile(no_outliers$revenue, .25)
