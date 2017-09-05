#using genetic algorithm for global optimization

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

library(fBasics)
#function for the log likelihood of the MLP
logfunc <- function(x,a,b){
  (1/(sqrt(2*pi)*b))*exp(-(log(x)-a)^2/(2*b^2))
}

parfunc <- function(x,c){
  x^(-c)
}

chab <- function(x,p){
  logfunc(x,p[2],p[3]) + ((parfunc(x,p[1]) - logfunc(x,p[2],p[3]))*0.5*(1+tanh((x-p[4])/0.5)))
}

loglikechab <- function(p){
  -sum(log(chab(mass,p)))
}


#package rgenoud for genetic algorithm optimization
library(rgenoud)

#boundary.enforcement is for constraints limitations
out <- genoud(loglikechab,nvars = 4, starting.values = c(1.72,0.109,0.09,1),Domains = matrix( c(1, 0, 0,0, 3, 3, 3,5), nrow=4, ncol=2),boundary.enforcement= 2, hessian = TRUE, optim.method = "SANN")
out

#package rgenoud for genetic algorithm optimization
library(DEoptim)

lower <- c(0,-3,0,0.5)
upper <- c(5,5,5,2)

set.seed(1234)
outDEoptim <- DEoptim(loglikechab, lower, upper, DEoptim.control(NP = 100, itermax = 1000, F = 1.2, CR = 0.7))
plot(outDEoptim)

