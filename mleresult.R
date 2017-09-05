#for generating Chabrier random numbers and combining data and MLE estimation for the hybrid MLP


getwd()
library(stats4)
#install.packages("NORMT3")
#library(NORMT3)
#install.packages("pracma") 
#can use this instead of NORMT3
#pracma for erfc...for complex valued arguments use erfz
library(pracma)

y <- rlnorm(5000, mean= log10(0.2), sd=0.55)
 summary(log(y))
 
 mean(log(y))
 sd(log(y))
