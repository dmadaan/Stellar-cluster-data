getwd()
library(stats4)
mass = scan('NGC.dat')

#plotting histogram #log10 base but y axis is mfm instead of log10(mfm)
n <- length(mass)
nbins <- 2*n^(2/5)
#nbins <- 51
histONC <- hist(log10(mass),nbins,freq = FALSE) #Check if this is good binning!


#function for the log likelihood of the MLP
mlp <- function(x,param){
  (param[1]*0.5)*exp((param[1]*param[2])+((param[1]*param[3])^2*0.5))*x^(-param[1])*erfc(((param[1]*param[3])-((log(x)-param[2])/param[3]))/sqrt(2))
}

MLPfunc <- function(param){
  -sum(log(mlp(mass,param)))
}

#maxLik package for the optimization
#install.packages("maxLik")
library(maxLik)
ml <- maxLik( MLPfunc, start = c(a = 1, b = -2, c = 1) )
print(summary(ml))

