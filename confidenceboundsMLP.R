getwd()
library(stats4)
#install.packages("NORMT3")
#library(NORMT3)
#install.packages("pracma") 
#can use this instead of NORMT3
#pracma for erfc...for complex valued arguments use erfz
library(pracma)

#loadign data
mass = scan('NGC.dat')

#plotting histogram #log10 base but y axis is mfm instead of log10(mfm)
n <- length(mass)
nbins <- 2*n^(2/5)
#nbins <- 51
histNGC1711 <- hist(log10(mass),nbins,freq = FALSE) #this gives me very bad binning! So alter

#function for the log likelihood of the MLP
mlp <- function(x,p){
  (p[1]*0.5)*exp((p[1]*p[2])+((p[1]*p[3])^2*0.5))*x^(-p[1])*erfc(((p[1]*p[3])-((log(x)-p[2])/p[3]))/sqrt(2))
}

loglikemlp <- function(p){
  -sum(log(mlp(mass,p)))
}

x = c(1.90,-0.109,0.001)
H <- hessian(loglikemlp, x)

V <- solve(H)                   # Covariance matrix
s <- sqrt(abs(diag(V)))    # Vector of standard deviations 
cor <- V/(s%o%s)            # Correlation coefficient matrix 
ci <- x+qnorm(0.975)*s%o%c(-1,1) # 95% CI's

