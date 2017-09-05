#ONC with DEoptim for the joined function using heaviside

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
#logfunc <- function(x,a,b){
# 0.076*exp(-(log(x)-a)^2/(2*b^2))
# }

logfunc <- function(x,a,b){
  (1/(sqrt(2*pi)*b*x))*exp(-(log(x)-a)^2/(2*b^2))
}

#parfunc <- function(x,c){
# 0.041*x^(-c)
#}

parfunc <- function(x,c,d){
  (c-1)*d^(c-1)*x^(-c)
}

chab <- function(x,p){
  logfunc(x,p[2],p[3])*(1 - Heaviside(x,a = p[4])) + parfunc(x,p[1],p[4])*Heaviside(x,a = p[4])
}


loglikechab <- function(p){
  -sum(log(chab(mass,p)))
}


#package rgenoud for differential evolution algorithm optimization
library(DEoptim)

lower <- c(1,-3,0,0.5)
upper <- c(5,5,5,2)

set.seed(1234)
outDEoptim <- DEoptim(loglikechab, lower, upper, DEoptim.control(NP = 100, itermax = 1000, F = 1.2, CR = 0.7))
plot(outDEoptim)

Iteration: 1000 bestvalit: 1668.411949 bestmemit:    2.168628   -1.646779    0.436547    0.502000
