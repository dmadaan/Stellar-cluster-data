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
mass = scan('Padnew.dat')

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




#package rgenoud for genetic algorithm optimization
library(rgenoud)

out <- genoud(loglikemlp,nvars = 3, starting.values = c(1.72,-0.109,0.09),Domains = matrix( c(1, -2, 0, 3, 3, 3), nrow=3, ncol=2),boundary.enforcement= 2, hessian = TRUE, optim.method = "SANN")
out
pop <- read.table('/tmp/RtmpnpcVyg/genoud.pro', comment.char = 'G') 
best <- pop[pop$V1 == 1,, drop = FALSE] 
very.best <- as.matrix(best[nrow(best), 3:ncol(best)]) 


#for Padnew



#This is for PADOVA i.e. with minimum mass as 0.90
alpha = 1.877
mu = -0.103
sigma = 0.01





#FOR Padbelow6 that is without high mass stars i.e. above 6 solar masses


Solution Fitness Value: 1.784598e+03

Parameters at the Solution (parameter, gradient):
  
  X[ 1] :	1.947274e+00	G[ 1] :	-8.317568e-06
X[ 2] :	-1.030410e-01	G[ 2] :	inf
X[ 3] :	5.544176e-13	G[ 3] :	0.000000e+00

Solution Found Generation 70
Number of Generations Run 100


#this was for MESA mimimum mass 0.89
Solution Fitness Value: 1.923792e+03

Parameters at the Solution (parameter, gradient):
  
  X[ 1] :	1.906220e+00	G[ 1] :	1.431401e-04
X[ 2] :	-1.094355e-01	G[ 2] :	0.000000e+00
X[ 3] :	5.645400e-10	G[ 3] :	0.000000e+00

Solution Found Generation 60
Number of Generations Run 81

Sun Nov  6 20:16:44 2016

#this is for MESAbelow 6

GENERATION: 17
Fitness value... 1.698910e+03
mean............ inf
variance........ inf
#unique......... 689, #Total UniqueCount: 12909
var 1:
  best............ 1.980568e+00
mean............ 1.979850e+00
variance........ 2.996327e-02
var 2:
  best............ -1.093161e-01
mean............ -6.439276e-02
variance........ 1.410549e-01
var 3:
  best............ 1.087634e-04
mean............ 1.009574e-01
variance........ 1.304035e-01\


#MESA Chab
GENERATION: 100
Fitness value... 2.997280e+04
mean............ inf
variance........ inf
#unique......... 631, #Total UniqueCount: 65543
var 1:
  best............ 2.171715e+00
mean............ 2.166049e+00
variance........ 1.967006e-02
var 2:
  best............ -1.120000e+00
mean............ -1.040975e+00
variance........ 2.041943e-01
var 3:
  best............ 5.430690e-01
mean............ 5.817183e-01
variance........ 6.168884e-02

NOTE: HARD MAXIMUM GENERATION LIMIT HIT
At least one gradient is too large

Solution Fitness Value: 2.997280e+04

Parameters at the Solution (parameter, gradient):
  
  X[ 1] :	2.171715e+00	G[ 1] :	-1.943265e-04
X[ 2] :	-1.120000e+00	G[ 2] :	4.117521e-03
X[ 3] :	5.430690e-01	G[ 3] :	-5.994057e-04

Solution Found Generation 54
Number of Generations Run 100


#padchab

GENERATION: 49
Fitness value... 2.976213e+04
mean............ inf
variance........ inf
#unique......... 700, #Total UniqueCount: 25218
var 1:
  best............ 2.199617e+00
mean............ 2.187849e+00
variance........ 1.866832e-02
var 2:
  best............ -1.083323e+00
mean............ -9.858969e-01
variance........ 2.561262e-01
var 3:
  best............ 5.536608e-01
mean............ 5.923333e-01
variance........ 5.939896e-02
