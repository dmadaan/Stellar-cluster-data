#using power-law package

getwd()
library(stats4)
#install.packages("NORMT3")
#library(NORMT3)
#install.packages("pracma") 
#can use this instead of NORMT3
#pracma for erfc...for complex valued arguments use erfz
library(pracma)

#loadign data
mass = scan('ONC.txt')

#plotting histogram #log10 base but y axis is mfm instead of log10(mfm)
n <- length(mass)
nbins <- 2*n^(2/5)
#nbins <- 51
histNGC1711 <- hist(log10(mass),nbins,freq = FALSE) #this gives me very bad binning! So alter

#install.packages("poweRlaw")
library(poweRlaw)


loglike <- function(p){
  -sum(dplcon(mass, p[2], p[1], log = TRUE)*Heaviside(x,a = p[4]))
}

lower <- c(1,0.5)#note that alpha has to be greater than 1 because in the maximum likelihood log(alpha-1) comes into picture. 
upper <- c(5,5)

set.seed(1234)
outDEoptim <- DEoptim(loglike, lower, upper, DEoptim.control(NP = 100, itermax = 1000, F = 1.2, CR = 0.7))
plot(outDEoptim)

