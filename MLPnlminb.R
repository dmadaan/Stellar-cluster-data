#using nlm for optimization but doesn't converge to one single value 

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
mlp <- function(x,p){
  (p[1]*0.5)*exp((p[1]*p[2])+((p[1]*p[3])^2*0.5))*x^(-p[1])*erfc(((p[1]*p[3])-((log(x)-p[2])/p[3]))/sqrt(2))
}

loglikemlp <- function(p){
  -sum(log(mlp(mass,p)))
}

#See demo(nlm)
#try mle2 package: bbmle ..
library(bbmle)

out <- nlminb(c(2.35,-0.12,0.09),loglikemlp, control = list(eval.max = 10000, iter.max = 1000), lower = c(0.1,-2,0),upper = c(3,3,3))
out

#est.no1 <- optim(out$par, loglikemlp, hessian=TRUE)
#this is not working!
