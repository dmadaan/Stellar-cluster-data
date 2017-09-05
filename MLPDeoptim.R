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
mass = scan('Padchabnew')

#plotting histogram #log10 base but y axis is mfm instead of log10(mfm)
n <- length(mass)
nbins <- 2*n^(2/5)
#nbins <- 51
histNGC1711 <- hist(log10(mass),nbins,freq = FALSE) #this gives me very bad binning! So alter



#function for the log likelihood of the MLP
mlp <- function(x,p){
  (p[1]*0.5)*exp((p[1]*p[2])+(((p[1]*p[3])^2)*0.5))*x^(-p[1]-1)*erfc(((p[1]*p[3])-((log(x)-p[2])/p[3]))/sqrt(2))
}

loglikemlp <- function(p){
  -sum(log(mlp(mass,p)))
}


#package rgenoud for genetic algorithm optimization
library(DEoptim)

lower <- c(0,-2,0)
upper <- c(5,5,5)

set.seed(1234)
outDEoptim <- DEoptim(loglikemlp, lower, upper, DEoptim.control(NP = 100, itermax = 1000, F = 1.2, CR = 0.7))
plot(outDEoptim)


#Deoptim estimate for Padnew 
Iteration: 1000 bestvalit: 4324.660065 bestmemit:    1.869625   -0.103041    0.000000

#Mesanew
Iteration: 1000 bestvalit: 4165.921327 bestmemit:    1.898167   -0.109435    0.000000

#Padbelow6new
Iteration: 1000 bestvalit: 3971.507831 bestmemit:    1.939417   -0.103041    0.000000

#Mesabelow6
Iteration: 1000 bestvalit: 3806.792919 bestmemit:    1.971397   -0.109435    0.000000

#Padchabnew
Iteration: 1000 bestvalit: 12116.667618 bestmemit:    2.092308   -1.044107    0.582392

