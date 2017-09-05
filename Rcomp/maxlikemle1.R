getwd()
library(stats4)
#install.packages("NORMT3")
#library(NORMT3)
#install.packages("pracma") 
#can use this instead of NORMT3
#pracma for erfc...for complex valued arguments use erfz
library(pracma)
mass = scan('NGC.dat')
#plotting histogram #log10 base but y axis is mfm instead of log10(mfm)
n <- length(mass)
nbins <- 2*n^(2/5)
#nbins <- 51
histONC <- hist(log10(mass),nbins,freq = FALSE) #this gives me very bad binning! So alter

#function for the log likelihood of the MLP
mlp <- function(x,a,b,c){
  (a*0.5)*exp((a*b)+((a*c)^2*0.5))*x^(-a)*erfc(((a*c)-((log(x)-b)/c))/sqrt(2))
}
  
loglikemlp <- function(a,b,c){
-sum(log(mlp(mass,a,b,c)))
}
#out <- mle(loglikemlp,start=list(a=1.72,b=-0.09,c=0.02),lower = c(0,-4,0),upper = c(5,5,5),method="L-BFGS")
#out <- mle(loglikemlp,start=list(a=1,b=-2,c=1),method="SANN")
#can use suppress Warnings for ignoring NaNs
#try mle2 package: bbmle ..
library(bbmle)
#out <- mle2(loglikemlp,start=list(a=1.72,b=-0.09,c=0.02),method="Nelder-Mead")
out <- nlm(loglikemlp,c(1.72,-0.09,0.02),hessian = TRUE)

#Nelder Mead doesn't give me a Hessian but converges to alpha = 1.92, mu = -0.109, sigma = 0
#Can control number of iterations or tolerance level to make it work!

