#Install and Loading in the required packages

install.packages("ggplot2")
install.packages("gridExtra")

library(ggplot2)
library(gridExtra)

#Code to define the random walk function, adjusted to allow for random seeds to be set. This is done by adjusting the function with 'set.seed' function which sets the seed of objects defined with this function to whatever number is designated to 'seed'
random_walk  <- function (n_steps, seed = NULL) {
  set.seed(seed)
  df <- data.frame(x = rep(NA, n_steps), y = rep(NA, n_steps), time = 1:n_steps)
  
  df[1,] <- c(0,0,1)
  
  for (i in 2:n_steps) {
    
    h <- 0.25
    
    angle <- runif(1, min = 0, max = 2*pi)
    
    df[i,1] <- df[i-1,1] + cos(angle)*h
    
    df[i,2] <- df[i-1,2] + sin(angle)*h
    
    df[i,3] <- i
    
  }
  
  return(df)
  
}

# Setting the seed for the first brownian motion under the term 'data1 with seed = 33' and defining the graph as 'plot1' to visualise the random behaviour:
data1 <- random_walk(500, seed = 33)

plot1 <- ggplot(aes(x = x, y = y), data = data1) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")

#The previous step is repeated with a new seed 'data2', this time set with a seed 52:
data2 <- random_walk(500, seed = 52)

plot2 <- ggplot(aes(x = x, y = y), data = data2) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")

# Finally, the graphs are plotted beside each other so that the different behaviours can be compared using the code below:
grid.arrange(plot1, plot2, ncol=2)
