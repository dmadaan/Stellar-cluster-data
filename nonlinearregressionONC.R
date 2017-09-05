#code works but need to use levenberg for proper analysis!Right now convergence is through Gauss Newton!

getwd()
#load data, if only column vector use scan instead of read.csv

mydata = scan("Dmassfile.txt")


#check min/max for the data

min(mydata)
max(mydata)

#plotting histogram #check if log base 10 or log base e
n <- length(mydata)
nbins <- 2*n^(2/5)
#nbins <- 51
histONC <- hist(log(mydata),nbins,freq = FALSE) #this gives me very bad binning! So alter

#instead of making the likelihood function use nls for non-linear regression and do AIC(fit) 
#2 ways of doing this problem: Use maximimze likelihood to maximize the likelihood function by optimization and then use the formula for AIC or do nls i.e. non-linear regression and use AIC(fit) to compute the value

xdata <- histONC$mids
ydata <- histONC$density

plot(ydata~xdata)

#log(logx) will give NaN as we call for MLP so we need to pass x and not logx through the fn

x <- exp(xdata)

#install.packages("NORMT3")
#library(NORMT3)

NGC1711.fit = nls(ydata~(a*0.5)*exp((a*b)+((a*c)^2*0.5))*x^(-a)*erfc(((a*c)-((log(x)-b)/c))/sqrt(2)),start=list(a=1, b=-1.5, c=0.6),model=T,trace=T)
#for a = 1, b = -1.5 and c = 0.6 it converges to 1.352 -2.0735 0.1834

summary(NGC1711.fit)

AIC(NGC1711.fit)
BIC(NGC1711.fit)

#check for error normality
par(mfrow=c(1,3))
qqnorm(residuals(NGC1711.fit)/summary(NGC1711.fit)$sigma)
abline(a=0,b=1)
shapiro.test(residuals(NGC1711.fit)/summary(NGC1711.fit)$sigma)

#we need to try the levenberg algorithm
#this doesn't work!
#install.packages("minpack.lm")
NGC1711.fit = nlsLM(ydata~(a*0.5)*exp((a*b)+((a*c)^2*0.5))*x^(-a)*erfc(((a*c)-((log(x)-b)/c))/sqrt(2)),start=list(a=1, b=-2, c=1),model=T,trace=T)

